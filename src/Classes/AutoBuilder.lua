-- Path of Building
--
-- Class: Auto Builder
-- Auto Builder Control.
--

local AutoBuilderClass = newClass("AutoBuilder", "ListControl", function(self, caller, anchor, x, y, width, height, label, builds)
	self.ListControl(anchor, x, y, width, height-50, 16, "VERTICAL", false, self:ReList())
	self.label = label	
	self.tooltip = new("Tooltip")
	self.controls.percentIncreasedLife = new("EditControl", {"TOPLEFT",self,"TOPRIGHT"}, 8, 28, 320, 20, 180, "Percent Increased Life", "%D", nil, function(buf)
	end)
	self.controls.autoBuilderLauncher = new("ButtonControl", {"TOPLEFT",self,"TOPRIGHT"}, 8, 0, 160, 20, "Go!", function()
		autoBuildMode = false
		self.label = "Building..."
		self.controls.autoBuilderLauncher.shown = false

		local SpecLifeInc
		for index, ds in ipairs(caller.build.displayStats) do
			if ds.stat == "spec_LifeInc" then
				SpecLifeInc = ds
				break
			end
		end

		caller.build.buildFlag = true
		caller.build.calcsTab.powerBuildFlag = true
		caller.build.calcsTab.powerStat = SpecLifeInc
		--self.controls.allocatedNodeToggle.enabled = false
		--self.controls.allocatedNodeDistance.enabled = false
		caller.build.calcsTab:PowerBuilder()

		local report = caller:BuildPowerReportList(SpecLifeInc)

		if SpecLifeInc.lowerIsBetter then
			table.sort(report, function (a,b)
				return a.pathPower < b.pathPower
			end)
		else
			table.sort(report, function (a,b)
				return a.pathPower > b.pathPower
			end)
		end

		local nodeAutoselected = nil
		for nodeId, node in pairs(caller.build.spec.nodes) do
			if nodeId == report[1].id then
				nodeAutoselected = node
			end
		end

		caller.build.spec:AllocNode(nodeAutoselected)

	end)
end)

function AutoBuilderClass:ReList()
end