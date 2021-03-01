-- TRIA64 OS written by Theamazingnater

local commandline = script.Parent.commandline
local commandlines = script.Parent.CommandLines
local commands = require(script.Parent.Commands)

local defaultline = "READY."
local looping = false

commandline.FocusLost:Connect(function(enterPressed)
	if enterPressed == true then
		-- Check the commandline's current text
		local text = commandline.Text
		if string.sub(text, 1, 6) == commands.printc then
			-- Get the rest of the text
			local messagetoPrint = text:sub(7)
			GenerateNewLine(messagetoPrint, 30)
		end
		if string.sub(text, 1, 4) == commands.help then
			-- Erase the screen, and then print out the commands
			EraseScreen(false)
			GenerateNewLine("PLEASE CHECK OUT THE GITHUB.", 40)
			wait(2)
			EraseScreen(true)
		end
		if string.sub(text, 1, 4) == commands.info then
			GenerateNewLine("Welcome to TRIA64!", 30)
			GenerateNewLine("This is a little thing I decided to make to test my skills!", 25)
			GenerateNewLine("Yeah, that's really all to it. Maybe someday I'll expand this.", 25)
		end
		if string.sub(text, 1, 5) == commands.erase then
			GenerateNewLine("ERASING SCREEN...", 40)
			wait(1)
			EraseScreen(true)
		end
		if string.sub(text, 1, 5) == commands.sound then
			-- Get the ID.
			local id = text:sub(6)
			-- If the id is blank, then play the default tone.
			if id == "" then
				script.noSound:Play()
			else
				-- It's a proper id! Create a sound effect, and play it!
				script.requestedSound:Stop()
				script.requestedSound.SoundId = "rbxassetid://" .. id
				script.requestedSound:Play()
			end
			GenerateNewLine("PLAYING SOUND WITH A ID OF " .. id, 40)
		end
		if string.sub(text, 1, 4) == commands.loop then
			if looping == false then
				looping = true
				script.requestedSound.Looped = true
				GenerateNewLine("SOUND IS NOW LOOPING.", 40)
			elseif looping == true then
				looping = false
				script.requestedSound.Looped = false
				GenerateNewLine("SOUND IS NO LONGER LOOPING.", 40)
			end
		end
		if string.sub(text, 1, 4) == commands.stop then
			script.requestedSound:Stop()
			GenerateNewLine("SOUND STOPPED.")
		end
	end
end)

function EraseScreen(hasReady)
	for i,v in pairs(commandlines:GetChildren()) do
		if v:IsA("TextLabel") then
			v:Destroy()
		end
	end
	if hasReady == true then
		GenerateNewLine(defaultline, 40)
	end
end

function GenerateNewLine(text, textSize)
	local newLine = script.lineTemplate:Clone()
	newLine.Text = text
	newLine.TextSize = textSize
	if text == defaultline then
		newLine.Name = "ready"
	else
		newLine.Name = "line"
	end
	-- Parent the new line into the CommandLines.
	newLine.Parent = commandlines
	-- Check the amount of lines on screen
	local children = commandlines:GetChildren()
	local amount = #children
	if amount > 11 then -- Maximum amount of lines on screen at once.
		-- Erase the entire screen.
		EraseScreen(true)
	end
end
