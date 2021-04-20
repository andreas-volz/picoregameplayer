 --[[
 =head1 NAME
 
 applets.Doomsday.DoomsdayApplet - Doomsday Applet
 
 =head1 DESCRIPTION
 
 This applet was created solely for the purpose of a demonstration
 
 =head1 FUNCTIONS
 
 Applet related methods are described in L<jive.Applet>. 
 
 =cut
 --]]
 
-----------------------------------------------------------------------------------------
local io            = require("io")
-----------------------------------------------------------------------------------------
 
 -- stuff we use
 local tostring = tostring
 local oo                     = require("loop.simple")
 local string                 = require("string")
 
 local Applet                 = require("jive.Applet")
 local RadioButton            = require("jive.ui.RadioButton")
 local RadioGroup             = require("jive.ui.RadioGroup")
 local Window                 = require("jive.ui.Window")
 local Popup                  = require("jive.ui.Popup")
 local Textarea               = require('jive.ui.Textarea')
 local SimpleMenu             = require("jive.ui.SimpleMenu")
 local Button                 = require("jive.ui.Button")
 local Framework              = require("jive.ui.Framework")

 module(...)
 oo.class(_M, Applet)
 
 function menu(self, menuItem)
 
       log:info("menu")
       local group = RadioGroup()
       local currentSetting = self:getSettings().currentSetting

       -- create a SimpleMenu object with selections to be created
       local menu = SimpleMenu("menu", {

                {
                        text = self:string("Bubble Bobble"),
                        sound = "WINDOWSHOW",
                        callback = function()
                                file = io.open("/tmp/jivelite_return", "w")
                                file:write("42")
                                file:close()
                                Framework.quit()
                                --os.exit(42)
                                --self:startSlideshow(false)
                                --return EVENT_CONSUME
                        end
                },


               -- first menu item
               {

                       -- text for the menu item
                       text = self:string("DOOMSDAY_OPTION1"),
                       -- add a radiobutton with a callback function to be used when selected
                       icon = RadioButton(
                               -- skin style of radio button (defined in DefaultSkin)
                               "radio",
                               -- group to attach button
                               group,
                               -- callback function
                               function()
                                       log:info("radio button 1 selected")
                                       -- show the warning
                                       self:warnMasses('DOOMSDAY_MESSAGE1')
                                       -- store the setting to settings.lua
                                       self:getSettings()['currentSetting'] = 1
                                       self:storeSettings()
                                       os.exit(42)
                               end,
                               -- fill the radio button if this is the currentSetting
                               (currentSetting == 1)
                       ),
               },
               {
                       text = self:string("DOOMSDAY_OPTION2"),
                       icon = RadioButton(
                               "radio",
                               group,
                               function()
                                       log:info("radio button 2 selected")
                                       self:warnMasses('DOOMSDAY_MESSAGE2')
                                       self:getSettings()['currentSetting'] = 2
                                       self:storeSettings()
                               end,
                               (currentSetting == 2)
                       ),
               },
               {
                       text = self:string("DOOMSDAY_OPTION3"),
                       icon = RadioButton(
                               "radio",
                               group,
                               function()
                                       log:info("radio button 3 selected")
                                       self:warnMasses('DOOMSDAY_MESSAGE3')
                                       self:getSettings()['currentSetting'] = 3 
                                       self:storeSettings()
                               end,
                               (currentSetting == 3)
                       ),
               },
               {
                       text = self:string("DOOMSDAY_OPTION4"),
                       icon = RadioButton(
                               "radio",
                               group,
                               function()
                                       log:info("radio button 4 selected")
                                       self:warnMasses('DOOMSDAY_MESSAGE4')
                                       self:getSettings()['currentSetting'] = 4
                                       self:storeSettings()
                               end,
                               (currentSetting == 4)
                       ),
               },
       })
 
       -- create a window object
       local window = Window("window", self:string("DOOMSDAY")) 
 
       -- add the SimpleMenu to the window
       window:addWidget(menu)

       -- show the window
       window:show()
 end
 
 function warnMasses(self, warning)
       log:info(self:string(warning))
 
       -- create a Popup object, using already established 'toast_popup_text' skin style
       local doomsday = Popup('toast_popup_text')
 
       -- add message to popup
       local doomsdayMessage = Group("group", {
                       text = Textarea('toast_popup_textarea',self:string(warning)),
             })
       doomsday:addWidget(doomsdayMessage)

       -- display the message for 3 seconds
       doomsday:showBriefly(3000, nil, Window.transitionPushPopupUp, Window.transitionPushPopupDown)
 end

