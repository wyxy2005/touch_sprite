--作用：一些备份的暂时没用到的函数
--时间：2017.2.28
--备注：
require("TSLib")

-- 计算两个点的相似度
local function calColorSimilary(color1, color2)
    local r1 = math.floor(color1 / (256 * 256))
    local g1 = math.floor((color1 - 256 * 256 * r1) / 256)
    local b1 = (color1 - 256 * 256 * r1) % 256

    local r2 = math.floor(color2 / (256 * 256))
    local g2 = math.floor((color2 - 256 * 256 * r2) / 256)
    local b2 = (color2 - 256 * 256 * r2) % 256

    local rSim = 1 - math.abs(r1 - r2) / 256
    local gSim = 1 - math.abs(g1 - g2) / 256
    local bSim = 1 - math.abs(b1 - b2) / 256

    return math.min(rSim, gSim, bSim)
end

-- 使用findMultiColorInRegionFuzzy实现多点找色
-- TSLib有了，不需要自己实现了
local function multiColor(data, sim)
    sim = sim or 1
    for i, v in ipairs(data) do
        if calColorSimilary(getColor(v[1], v[2]), v[3]) < sim then
            return false
        end
    end
    return true
end