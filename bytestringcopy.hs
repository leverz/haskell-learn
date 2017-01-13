import System.Environment
import qualified Data.ByteString.Lazy as B

main = do
    (fileName:fileName2:_) <- getArgs
    copyFile fileName1 fileName2

copyFile :: filePath -> filePath -> IO ()
copyFile source dest = do
    contents <- B.readFile source
    B.writeFile dest contents
 