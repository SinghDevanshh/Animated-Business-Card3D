myEntities model =  
    [
    square3D 2000 -- This is the floor
        |> metallic (Color.rgb 192 192 192) 0.75
        |> move3D (0,0,-100)
        ,
        
        -- Moving Card starts here :-
        rectangle3D 50 100 
         {-
         textured
         Use a custom texture made for 2d card combined with a 
         svgTextures to impose it over the 3d card.
         -}
        |> textured (getColorTexture "squares" model) (constantTexture 0) (constantTexture 0)
        
        -- Orientation for the moving card to get it to the right spot.
        |> move3D (0,0,300)
        |> rotateZ3D (degrees 135)
        |> rotateY3D (degrees 180)
        |> move3D (0,0,400)
        
        -- the movement function of the card using repeatDistance
        |> move3D (0,0,(repeatDistance -20 190.2 0 model.time))
        
        ,

        
        -- The card stack of all bottom not moving card starts here:-
        bottomStack 0.5
        ,
        bottomStack 1
        ,
        bottomStack 1.5
        ,
        bottomStack 2
        ,
        bottomStack 2.5
        ,
        bottomStack 3
        ,
        bottomStack 3.5
        ,
        bottomStack 4
        ,
        bottomStack 4.5
        ,
        bottomStack 5
        ,
        bottomStack 5.5
        ,
        bottomStack 6
        ,
        bottomStack 6.5
        ,
        
        -- The card on top of the stack of cards
        rectangle3D 50 100 
        |> textured (getColorTexture "squares" model) (constantTexture 0) (constantTexture 0)
        |> move3D (0,0,300)
        |> rotateZ3D (degrees 135)
        |> rotateY3D (degrees 180)
        |> move3D (0,0,207)
        ,
        group3D[
        -- Moving Card starts here :-
        rectangle3D 50 100 
         {-
         textured
         Use a custom texture made for 2d card combined with a 
         svgTextures to impose it over the 3d card.
         -}
        |> textured (getColorTexture "squares" model) (constantTexture 0) (constantTexture 0)
        |> rotateZ3D (degrees (180))

        -- the movement function of the card using repeatDistance
        |> rotateY3D (degrees (model.time*30))
        |> move3D (200,0,0)
        
        -- some rgb spheres to reduce the monotonous environment
        {-
        ,
        sphere 15
        |> metallic (Color.hsl (degrees model.time) 0.5 0.5 ) 0.25
        |> move3D (200,150,200)
        |> move3D (0,0,(repeatDistance -40 295.05 0 model.time))
        ,
        sphere 20
        |> metallic (Color.hsl (degrees model.time) 0.5 0.5 ) 0.25
        |> move3D (100,150,200)
        |> move3D (0,0,(repeatDistance -40 295.05 0 model.time))
        ,
        sphere 15
        |> metallic (Color.hsl (degrees model.time) 0.5 0.5 ) 0.25
        |> move3D (200,-150,200)
        |> move3D (0,0,(repeatDistance -40 295.05 0 model.time))
        ,
        sphere 20
        |> metallic (Color.hsl (degrees model.time) 0.5 0.5 ) 0.25
        |> move3D (100,-150,200)
        |> move3D (0,0,(repeatDistance -40 295.05 0 model.time))
        -}
        ]
        ]
        

cloud = group3D [
           sphere 20
           |> matte Color.white
           ,
           sphere 20
           |> matte Color.white
           |> move3D (0,10,0)
           ,
           sphere 20
           |> matte Color.white
           |> move3D (10,0,0)
           ,
           sphere 20
           |> matte Color.white
           |> move3D (10,0,0)
           
              ]

{- 
FUNCTION ::: bottomStack x
Function to make a template of the cards at the bottom of the stack
-}

bottomStack x = group3D [
          rectangle3D 50 100 
            |> metallic (Color.purple) 0.75
            |> move3D (0,0,-100)
            |> move3D (0,0,x)
            |> rotateZ3D (degrees 45)
          ]


{- 
FUNCTION ::: recursiveLines x
Recursive function to make a pattern of black lines on the card
-}           


recursiveLines c = group[
  if c == -38
  then
  group [] 
  else 
  group [
  smallline black 0.6
  |> move (c,0)
  ,
  recursiveLines (c-1)
   ]
 ]
 
snow x = group3D [
        sphere 0.5
        |> matte Color.white
        |> move3D (0,100+x,200) 
        ]
        

{-
Card group holds the 2d card which is later turned svgTexture
-}

card = group [
    -- The background (base) for the card
    mainCard
    ,
    -- Gradient lines defined below
    lines
    , 
    
    -- smallline defined below
    smallline black 0.6
    |> move (-41,0)
    |> clip (mainCard)
    ,
    smallline black 0.6
    |> move (-40,0)
    |> clip (mainCard)
    ,
    smallline black 0.6
    |> move (-39,0)
    |> clip (mainCard)
    ,
    
    -- recursiveLines called here for the lines
    recursiveLines 38
    
    ,
    smallline black 0.6
    |> move (39,0)
    |> clip (mainCard)
    ,
    smallline black 0.6
    |> move (40,0)
    |> clip (mainCard)
    ,
    smallline black 0.6
    |> move (41,0)
    |> clip (mainCard)
    ,
    
 -- circles function defined below used in to add transparent circles
    circles 6 0.4
    |> move (-30,-10)
    |> clip (mainCard)
    ,
    circles 10 0.4
    |> move (-5,3)
    |> clip (mainCard)
    ,
    circles 9 0.4
    |> move (-37,12)
    |> clip (mainCard)
    ,
    circles 5 0.4
    |> move (-20,12)
    ,
    circles 2 0.4
    |> move (-14,-18)
    ,
    circles 2 0.4
    |> move (3,-15)
    ,
    circles 4 0.4
    |> move (-6,-12)
    ,
    
    -- alltext group defined below used for all the text on the card
    alltext
 
    ]
    
{- 
Group ::: mainCard
Function to make the base for the card also used in the clip 
function above
-} 

mainCard = group [
     roundedRect 80 40 5
       |> filled (rgb 64 11 170)
       ]         
{- 
FUNCTION ::: circles x y
Function to make circles of differnt sizes and different visibility
-}     

circles c d = group [
    circle c
    |> filled (hsl (degrees 274) 0.984 0.761)
    |> makeTransparent d
    
              ] 

{- 
Group ::: alltext
Function to make circles of differnt sizes and different visibility
-}     
              
alltext = group [
    text "Devansh Singh"
    |> italic
    |> filled white
    |> scale 0.5
    |> move (-33,-1.5)
    ,
    text "📞 : 123-456-6789"
    |> filled white
    |> scale 0.25
    |> move (12,-9)
    ,
    text "✉ : id@mcmaster.ca"
    |> filled white
    |> scale 0.25
    |> move (0,-12)
    ,
    text "McMaster University"
    |> filled white
    |> scale 0.2
    |> move (15,-15)
    |> makeTransparent 0.92
    ,
    text "Hamilton, ON"
    |> filled white
    |> scale 0.2
    |> move (15,-18)
    |> makeTransparent 0.92
    , 
    text "Computer Science"
    |> filled white
    |> scale 0.2
    |> move (-30,-6)
         ]

{- 
Function ::: smallline
Function to make lines of different colours and visibilty
-}  

smallline c d = group [
    rect 0.6 7
    |> filled c
    |> makeTransparent d
    |> rotate (degrees -30)
              ]
{- 
Function ::: line
Function to make lines of different colours and visibilty and bigger size than smallline
-}  

line c d = group [
    rect 3 50
    |> filled c
    |> makeTransparent d
    |> rotate (degrees 30)
              ]

{- 
Group ::: lines
Group of all the gradient lines on the card
-}  

lines = group [
    line (rgb 85 37 170) 0.7
    |> move (10,0)
    |> clip (mainCard)
    ,
    line (rgb 85 37 170) 0.6
    |> move (15,0)
    |> clip (mainCard)
    ,
    line (rgb 85 37 170) 0.5
    |> move (20,0)
    |> clip (mainCard)
    ,
    line (rgb 85 37 170) 0.4
    |> move (25,0)
    |> clip (mainCard)
    ,
    line (rgb 85 37 170) 0.3
    |> move (30,0)
    |> clip (mainCard)
    ]
    
-- Custom colour defined ::-
gold = hsl (degrees 55 ) 0.834 0.63


-- move / edit the light
lightData =
    { position = Point3d.centimeters 0 100 225  -- position of the light
    , chromaticity = Light.sunlight             -- the colour of the light (see https://package.elm-lang.org/packages/ianmackenzie/elm-3d-scene/latest/Scene3d-Light#Chromaticity)
    , intensity = LuminousFlux.lumens 25000     -- how intense the light is
    , castsShadows = True                       -- whether the light will cast shadows
    , showEntity = False                         -- whether the light ball will be rendered (the light itself shines regardless)
    }

-- Use "loadTexture [name] [type] [url]" to load in texture images from the Internet!
-- Give each one a unique name, and specify its type (TexColor, TexRoughness, or TexMetallicity).
-- You can list many of them!
myTextures = 
    [ loadTexture "example" TexColor "Put an image URL here!"
    ]

-- Usage: `svgTexture "name" "type" shape`, where shape is any 2D shape or group
-- Give each one a unique name, and specify its type (TexColor, TexRoughness, or TexMetallicity).
-- You can list many of them!
svgTextures =
    [ svgTexture "squares" TexColor squares
    ]

-- SVG textures are 50 by 50
squares = group [
-- converting the 2d card to a SVG textures and scaling accordingly
          card
          |> scaleY 1.25
          |> scaleX 0.7
            ]


-- Put your 2D shapes here, and they will be overlayed on top of the screen!
overlay : Model -> List (Shape Msg)
overlay model =
    [ 
--    squared
    {-
    angleDisplay model
    , cameraControls model
    , circle 10 |> filled red |> move (100, 0)
    -}
    ]
-- Here you can specify what images to use to create the skybox.
skyboxType =
    Skybox.URLSkybox
        "Skybox Top URL"
        "Skybox Bottom URL"
        "Skybox Side 1 URL"
        "Skybox Side 2 URL"
        "Skybox Side 3 URL"
        "Skybox Side 4 URL"
        1000
    -- Some other options (comment in the one above and comment one of these out)
    -- Skybox.GSVGSkybox False skyboxTop skyboxSides skyBoxBottom 500
    -- Skybox.GSVGSphericalSkybox False skyboxTop 500
    -- Skybox.URLSphericalSkybox "https://cschank.github.io/img/milky.jpg" 1000

-- this is 50 by 50
skyboxTop : Shape msg
skyboxTop =
    group
        [
            square 50 |> filled white
        ,   circle 10 |> filled yellow
        ]

-- this is 200 by 50
skyboxSides : Shape msg
skyboxSides =
    group
        [
            rect 200 50 |> filled lightBlue |> move (0,25)
        ,   rect 200 50 |> filled green |> move(0,-25)
        ,   triangle 10 |> filled darkGreen |> rotate (degrees -30) |> move (0,5)
        ,   text "abcdefghijklmnopqrstuvwxyz" |> centered |> size 16 |> filled red
        ]

-- this is 50 by 50
skyBoxBottom : Shape msg
skyBoxBottom =
    group
        [
        ]

-- You can add your own data to the model, but don't remove anything or else things won't work anymore.
-- If you add your own values to track, make sure you also add an initial value under `init`!
type alias Model =
    { width : Quantity Int Pixels
    , height : Quantity Int Pixels
    , time : Float
    , meshStore : MeshStore WorldCoordinates
    , widget : Widget.Model
    , gSkyboxModel : GS.Model
    , gTextureModel : GT.Model
    , cameraModel : W3C.Model WorldCoordinates
    , textureLoader : TL.Model
    , zoomSpeed : Length
    }

init : ( Model, Cmd Msg )
init =
    let
        (wModel, _) = Widget.init 0 0 "widget"
        (gSkyboxModel, gSCmd) = GS.initialModel

        allSvgTextures = svgTextures ++
            (case skyboxType of
                 Skybox.GSVGSkybox _ top sides bottom _ ->
                     GS.getTexturesToLoad top sides bottom
                 Skybox.GSVGSphericalSkybox _ shape _ ->
                     GS.getTexturesToLoad shape (group []) (group [])
                 _ -> []
            )

        (gTextureModel, gTCmd) = GT.initialModel allSvgTextures
    in
    ( { width = Quantity.zero
      , height = Quantity.zero
      , time = 0
      , meshStore = { generatedMeshes = Dict.empty, generatedShadows = Dict.empty }
      , widget = wModel
      , gSkyboxModel = gSkyboxModel
      , gTextureModel = gTextureModel
      , cameraModel = W3C.basicCamera
      , textureLoader = TL.init
      , zoomSpeed = Length.centimeters 15
      }
    , Cmd.batch
        [ Cmd.map TextureLoadMsg <| case skyboxType of
            Skybox.URLSkybox top bottom side1 side2 side3 side4 _ ->
                TL.fetchTextures
                    ( [ loadTexture "skyB" TexColor bottom
                      , loadTexture "skyT" TexColor top
                      , loadTexture "skyS1" TexColor side1
                      , loadTexture "skyS2" TexColor side2
                      , loadTexture "skyS3" TexColor side3
                      , loadTexture "skyS4" TexColor side4
                      ] ++ myTextures
                    )
                    TL.init
            Skybox.URLSphericalSkybox texture _ ->
                TL.fetchTextures
                    ( loadTexture "skyT" TexColor texture :: myTextures )
                    TL.init
            _ -> TL.fetchTextures myTextures TL.init
        , case skyboxType of
            Skybox.GSVGSkybox _ _ _ _ _ -> Cmd.map SkyboxMsg gSCmd
            Skybox.GSVGSphericalSkybox _ _ _ -> Cmd.map SkyboxMsg gSCmd
            _ -> Cmd.none
        , Cmd.map GSVGTextureMsg gTCmd
        ]
    )

-- Do not remove any of these message types.
-- If you add your own, remember to also handle them in the `update` function!
type Msg
    = Tick Duration
    | WidgetMsg Widget.Msg
    | SkyboxMsg GS.Msg
    | GSVGTextureMsg GT.Msg
    | TextureLoadMsg TL.Msg
    | CameraMsg (W3C.Msg WorldCoordinates)

update message model =
    case message of
        -- This gets called around 60 times per second
        Tick t ->
           let
                tickRate =
                    Duration.milliseconds 1 |> Quantity.per Duration.second

                updatedTime =
                    Duration.seconds model.time |> Quantity.plus (tickRate |> Quantity.for t)

                timeAsNum = Duration.inSeconds updatedTime

            in
                ( { model | time = timeAsNum }
                , Cmd.none
                )

        -- This is needed for our overlay
        WidgetMsg wMsg ->
            let
                (newWModel, wCmd) = Widget.update wMsg model.widget
            in
            ( { model | widget = newWModel }, Cmd.map WidgetMsg wCmd )

        SkyboxMsg sMsg ->
            let
                (gSkyboxModel, gSCmd) = GS.update sMsg model.gSkyboxModel
            in
                ( { model | gSkyboxModel = gSkyboxModel } , Cmd.map SkyboxMsg gSCmd)

        GSVGTextureMsg tMsg ->
            let
                (gTextureModel, gTCmd) = GT.update tMsg model.gTextureModel
            in
                ( { model | gTextureModel = gTextureModel }
                , case tMsg of
                    GT.GeneratedPNG (name, imgURL) ->
                        let
                            nameOnly =
                                case List.head (List.reverse (String.indices "Tex" name)) of
                                    Nothing ->
                                        name
                                    Just i ->
                                        name |> String.left i
                            texType =
                                case TL.readTextureType (String.dropLeft (String.length nameOnly) name) of
                                    Nothing ->
                                        TexColor
                                    Just tex ->
                                        tex
                        in
                            Cmd.batch
                                [ Cmd.map TextureLoadMsg
                                    ( TL.fetchTexture
                                        ( loadTexture
                                            nameOnly
                                            texType
                                            imgURL
                                        )
                                        model.textureLoader
                                    )
                                , Cmd.map GSVGTextureMsg gTCmd
                                ]
                    _ -> Cmd.map GSVGTextureMsg gTCmd
                )

        TextureLoadMsg tlMsg ->
            let
                (tlModel, tlCmd) = TL.update tlMsg model.textureLoader
            in
            (
                { model | textureLoader = tlModel }
            ,   Cmd.map TextureLoadMsg tlCmd
            )

        CameraMsg camMsg ->
            let
                w3cModel = W3C.update camMsg model.cameraModel
            in
                ( { model | cameraModel = w3cModel }
                , Cmd.none
                )

