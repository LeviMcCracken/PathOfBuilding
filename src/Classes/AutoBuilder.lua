-- Path of Building
--
-- Class: Auto Builder
-- Auto Builder Control.
--

local AutoBuilderClass = newClass("AutoBuilder", "ListControl", function(self, anchor, x, y, width, height, label, builds)
	self.ListControl(anchor, x, y, width, height-50, 16, "VERTICAL", false, self:ReList())
	self.label = label	
	self.tooltip = new("Tooltip")
	self.controls.autoBuilderLauncher = new("ButtonControl", {"BOTTOMRIGHT",self,"TOPRIGHT"}, 8, 4, 160, 20, "Go!", function()
		self.label = "Building..."
		self.controls.autoBuilderLauncher.shown = false
	end)
end)

function AutoBuilderClass:ReList()
end