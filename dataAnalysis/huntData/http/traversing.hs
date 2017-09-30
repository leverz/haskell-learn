import Network.HTTP
import Network.URI (parseURI)
import Text.XML.HXT.Core
import Text.HandsomeSoup
import Data.Maybe (fromJust)

type SearchResult = Either SearchResultErr [String]
data SearchResultErr = NoResultsErr
                     | TooManyResultsErr
                     | UnknowErr
                     deriving (Show, Eq)

myRequestURL = "http://www.virginia.edu/cgi-local/ldapweb"

myRequest :: String -> Request_String
myRequest query = Request {
    rqURI = fromJust $ parseURI myRequestURL
  , rqMethod = POST
  , rqHeaders = [ mkHeader HdrContentType "text/html"
                , mkHeader HdrContentLength $ show $ length body ]
  , rqBody = body
  }
  where body = "whitepages=" ++ query

getDoc query = do
  rsp <- simpleHTTP $ myRequest query
  html <- getResponseBody rsp
  return $ readString [withParseHTML yes, withWarnings no] html

scanDoc doc = do
  errMsg <- runX $ doc >>> css "h3" //> getText

  case errMsg of
    [] -> do
        text <- runX $ doc >>> css "td" //> getText
        return $ Right text
    "Error: Sizelimit exceeded":_ ->
        return $ Left TooManyResultsErr
    "Too many matching entries were found":_ ->
        return $ Left TooManyResultsErr
    "No matching entries were found":_ ->
        return $ Left NoResultsErr
    _ -> return $ Left UnknowErr

main :: IO ()
main = main' "a"

{--
 -- 谈谈这里获得的一些体会吧
 -- Haskell 中用递归代替了常见的命令式语言的循环，这让我想起了最近一直在搞一些数据脚本的事情
 -- 有些数据在查询时存在数据量过大，导致连接超时或者 sizelimit exceeded 之类的错误
 -- 为了处理这种大数据量的情况，我把每次请求的数据量限制在一个较小的确保可以正常运行的条件下，然后循环采集数据，直到计算完全部的数据
 -- 再看 Haskell 这里的处理方式，它并没有设定一个可运行的假定的数据量，而是把出现 sizelimit exceeded 这样的错误当做是很正常的情况
 -- 让程序自行寻找一个最合适的条件
 -- 这种方式足够引起我们的思考，有时候报错不一定意味着程序的崩溃，报错可能是我们的条件不够合理，那就让它自己去寻找更合理的条件
 --}

main' query = do
  print query
  doc <- getDoc query
  searchResult <- scanDoc doc
  print searchResult
  case searchResult of
    Left TooManyResultsErr -> 
      main' (nextDeepQuery query)
    _ -> if (nextQuery query) >= endQuery
          then print "done!" else main' (nextQuery query)

nextDeepQuery query = query ++ "a"

nextQuery "z" = endQuery
nextQuery query = if last query == 'z' 
                  then nextQuery $ init query
                  else init query ++ [succ $ last query]
endQuery = [succ 'z']