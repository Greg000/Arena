--[[一个运动系统应该满足以下功能:
    投射物
    起点
    终点（静态/动态）
    起始速度
    加速度]]--
require("lib/timers")

if motion_system == nil then
    motion_system = class({})
end

function motion_system:FinishwithinTime( table )
end

function motion_system:Launch ( table )

