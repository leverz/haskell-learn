type Name = String
type Data = String
data FSItem = File Name Data | Folder Name [FSItem] deriving (Show)

myDisk :: FSItem
myDisk = 
  Folder "root"
    [ File "goat_yelling_like_man.wmv" "baaaaaaaa"
    , File "pope_time.avi" "smash!!"
    , Folder "pics"
      [ File "skull_man(scary).bmp" "Yikes!"
      , File "watermelon_smash.gif" "smash!!"
      , File "age_throwing_up.jpg" "bleargh"
      ]
    , File "dijon_poupon.doc" "best mustard"
    , Folder "programs"
      [ File "fartwizard.exe" "10gotofart"
      , File "owl_bandit.dmg" "mov eax, h00t"
      , File "not_a_virus.exe" "really not a virus"
      , Folder "source code"
        [ File "best_hs_prog.hs" "main = print (fix error)"
        , File "random.hs" "main = print 4"
        ]
      ]
    ]