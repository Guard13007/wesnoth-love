love = love
log  = (require"log")"titleScreen"
moan = require"client.lib.Moan.Moan"!
get_image = require"client.image.image_path"

local main_menu
local width


local background, foreground, logo, logo_bg
load_images = ->

    gameState = gameState

    with gameState.gameConfig.images
        foreground = get_image(.game_title)
        background = get_image(.game_title_background)
        logo       = get_image(.game_logo)
        logo_bg    = get_image(.game_logo_background)


-- tips = {}
-- setup_tips = ->
    -- moan = require"client.lib.Moan.Moan"
    -- for tip in *DATA.Tip
    --     title   = {tip.source, titleColor}
    --     message = {tip.text}
    --     config  = {
    --         image: logo_bg
    --     }
    --     moan.speak(title, message, config)


audio = ->
    -- require 'client.lib.slam.slam'

    title_music = gameState.gameConfig.title_music
    love_music_path = "assets/data/core/music/" .. title_music

    -- love_music_path = get.assets"data/core/music/love_theme.ogg"
    -- creates a new SLAM source
    music = love.audio.newSource(love_music_path, 'stream')
    -- all instances will be looping
    music\setLooping(false)
    -- set volume for all instances
    music\setVolume(.3)
    -- play music
    love.audio.play(music)
    -- woosh = love.audio.newSource({'woosh1.ogg', 'woosh2.ogg'}, 'static')


draw = ->
    screen_height = love.graphics.getHeight!
    screen_width  = love.graphics.getWidth!

    background_x = (screen_width  - background\getWidth! ) / 2
    background_y = (screen_height - background\getHeight!) / 2
    love.graphics.draw(background, background_x, background_y)
    love.graphics.draw(background, background_x + background\getWidth!,
        background_y,
        0, -1, 1, width, 0)
    love.graphics.draw(background, background_x - background\getWidth!,
        background_y,
        0, -1, 1, width, 0)

    foreground_x = (screen_width  - foreground\getWidth! ) / 2
    foreground_y = (screen_height - foreground\getHeight!) / 2
    love.graphics.draw(foreground, foreground_x, foreground_y)

    logo_padding = 5

    logo_bg_x = (screen_width - logo_bg\getWidth! ) / 2
    logo_bg_y = if background_y > 0
        background_y + logo_padding
    else
        logo_padding
    love.graphics.draw(logo_bg, logo_bg_x, logo_bg_y)

    logo_x = (screen_width - logo\getWidth! ) / 2
    logo_y = if background_y > 0
        background_y + logo_padding
    else
        logo_padding
    love.graphics.draw(logo, logo_x, logo_y)

    moan.draw!


update = (dt) ->
    -- love.audio.setVolume(love.audio.getVolume! - dt )
    moan.update(dt)


-- -- @todo this makes moan to do 2 steps at once when combined with keypressed
-- keyreleased = (key) ->
--     moan.keyreleased(key)
keypressed = (key) ->
    switch key
        when 'f5'
            love.event.quit('restart')
        when 'escape'
            love.event.quit!
        else
            moan.keypressed(key)


open = ->
    if love.audio
        audio!
    load_images!
    -- setup_tips!
    main_menu\show!
    love.mouse.setPosition(main_menu.mainMenu\getX!,
        main_menu.mainMenu\getY!)
    love.mouse.setVisible( true )


close = ->
    main_menu\hide!

return (screen) ->
    main_menu = (require"client.gui.dialogs.main_menu")screen
    log.info"title_screen.load"


    return {
        :open
        :close

        :keypressed

        :update
        :draw
    }
