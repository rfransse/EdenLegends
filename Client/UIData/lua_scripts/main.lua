-----------------------------------------
-- Start of handler functions
-----------------------------------------
-----------------------------------------
-- Alpha slider handler (not used!)
-----------------------------------------
function sliderHandler(args)
	CEGUI.System:getSingleton():getGUISheet():setAlpha(CEGUI.toSlider(CEGUI.toWindowEventArgs(args).window):getCurrentValue())
end

function CloseFrame( args )
	local frameWnd = CEGUI.WindowManager:getSingleton():getWindow("Root")
	frameWnd:setVisible( false )
end

-----------------------------------------
-- Handler to slide pane
--
-- Here we move the 'Demo8' sheet window
-- and re-position the scrollbar
-----------------------------------------
function panelSlideHandler(args)
	local scroller = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window)
	local demoWnd = CEGUI.WindowManager:getSingleton():getWindow("Demo8")

    local relHeight = demoWnd:getHeight():asRelative(demoWnd:getParentPixelHeight())

	scroller:setPosition(CEGUI.UVector2(CEGUI.UDim(0,0), CEGUI.UDim(scroller:getScrollPosition() / relHeight,0)))
	demoWnd:setPosition(CEGUI.UVector2(CEGUI.UDim(0,0), CEGUI.UDim(-scroller:getScrollPosition(),0)))
end

-----------------------------------------
-- Handler to set preview colour when
-- colour selector scrollers change
-----------------------------------------
function colourChangeHandler(args)

	local winMgr = CEGUI.WindowManager:getSingleton()

	local r = CEGUI.toScrollbar(winMgr:getWindow("Demo8/Window1/Controls/Red")):getScrollPosition()
	local g = CEGUI.toScrollbar(winMgr:getWindow("Demo8/Window1/Controls/Green")):getScrollPosition()
	local b = CEGUI.toScrollbar(winMgr:getWindow("Demo8/Window1/Controls/Blue")):getScrollPosition()
	local col = CEGUI.colour:new_local(r, g, b, 1)
    local crect = CEGUI.ColourRect(col)

	winMgr:getWindow("Demo8/Window1/Controls/ColourSample"):setProperty("ImageColours", CEGUI.PropertyHelper:colourRectToString(crect))
end

function ScrollChangeHandler( args )

	local winMgr = CEGUI.WindowManager:getSingleton()
	local value1 = CEGUI.toScrollbar(winMgr:getWindow("Root/VideoSet/CharScroll")):getScrollPosition()
	local value2 = CEGUI.toScrollbar(winMgr:getWindow("Root/VideoSet/SceneScroll")):getScrollPosition()
	local value3 = CEGUI.toScrollbar(winMgr:getWindow("Root/VideoSet/EffectScroll")):getScrollPosition()
	winMgr:getWindow("Root/VideoSet/CharDisValueLb" ):setText(value1)
	winMgr:getWindow("Root/VideoSet/SceneRangeValueText" ):setText(value2)
	winMgr:getWindow("Root/VideoSet/EffectValueLb" ):setText(value3)


end

-----------------------------------------
-- Handler to add an item to the box
-----------------------------------------
function addItemHandler(args)
	local winMgr = CEGUI.WindowManager:getSingleton()

	local text = winMgr:getWindow("Demo8/Window1/Controls/Editbox"):getText()
	local cols = CEGUI.PropertyHelper:stringToColourRect(winMgr:getWindow("Demo8/Window1/Controls/ColourSample"):getProperty("ImageColours"))

	local newItem = CEGUI.createListboxTextItem(text, 0, nil, false, true)
	newItem:setSelectionBrushImage("TaharezLook", "MultiListSelectionBrush")
	newItem:setSelectionColours(cols)

	CEGUI.toListbox(winMgr:getWindow("Demo8/Window1/Listbox")):addItem(newItem)
end

-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr = CEGUI.WindowManager:getSingleton()
--local fontman   = CEGUI.FontManager:getSingleton()

-- load our demo8 scheme
schemeMgr:loadScheme("Demo8.scheme");
schemeMgr:loadScheme("AquaLookSkin.scheme");
schemeMgr:loadScheme("WindowsLook.scheme");
--local font = fontman:createFont("fonts/ChineseFont-12.font")
-- load and set default font
--system:setDefaultFont( font )

-- load our demo8 window layout
-- local root = winMgr:loadWindowLayout("Demo8.layout")
local SheetRoot = winMgr:loadWindowLayout("VideoSet.layout")

local Listbox = winMgr:getWindow("Root/VideoSet/resolutionComboBox");



-- set the layout as the root
guiSystem:setGUISheet(SheetRoot)
--guiSystem:getGUISheet():addChildWindow(SheetRoot)
--guiSystem:setGUISheet(SheetRoot)
-- set default mouse cursor
guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow")
-- set the Tooltip type
guiSystem:setDefaultTooltip("TaharezLook/Tooltip")



-- subscribe required events
--winMgr:getWindow("Demo8/ViewScroll"):subscribeEvent("ScrollPosChanged", "panelSlideHandler")
--winMgr:getWindow("Demo8/Window1/Controls/Blue"):subscribeEvent("ScrollPosChanged", "colourChangeHandler")
--winMgr:getWindow("Demo8/Window1/Controls/Red"):subscribeEvent("ScrollPosChanged", "colourChangeHandler")
--winMgr:getWindow("Demo8/Window1/Controls/Green"):subscribeEvent("ScrollPosChanged", "colourChangeHandler")
--winMgr:getWindow("Demo8/Window1/Controls/Add"):subscribeEvent("Clicked", "addItemHandler")

winMgr:getWindow("Root/VideoSet/CharScroll"):subscribeEvent("ScrollPosChanged", "ScrollChangeHandler")
winMgr:getWindow("Root/VideoSet/SceneScroll"):subscribeEvent("ScrollPosChanged", "ScrollChangeHandler")
winMgr:getWindow("Root/VideoSet/EffectScroll"):subscribeEvent("ScrollPosChanged", "ScrollChangeHandler")

-- Add ListBox Items

winMgr:getWindow("Root/VideoSet/Btn6"):subscribeEvent("Clicked","CloseFrame")
