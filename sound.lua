--- @module sound
local m_sound = {}

local snd_apple_bite = nil
local snd_death      = nil
local snd_the_end    = nil

-------------------------------------------------------------------------------
function m_sound.init()
	local music = love.audio.newSource("FurElise.ogg", "stream")
	music:setLooping(true)
	music:play()
	snd_apple_bite = love.audio.newSource("Apple_Bite-Simon_Craggs-1683647397.mp3", "static")
	snd_death      = love.audio.newSource("Blast-SoundBible.com-2068539061.mp3", "static")
	snd_the_end    = love.audio.newSource("Ta Da-SoundBible.com-1884170640.wav")
end

-------------------------------------------------------------------------------
function m_sound.apple_bite()
	snd_apple_bite:stop()
	snd_apple_bite:play()
end

-------------------------------------------------------------------------------
function m_sound.death()
	snd_death:play()
end

-------------------------------------------------------------------------------
function m_sound.the_end()
	love.audio.stop()
	snd_the_end:play()
end

-------------------------------------------------------------------------------
return m_sound
