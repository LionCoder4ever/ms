local type = type
local str_len = string.len
local str_find = string.find
local mt_floor = math.floor
local mt_abs = math.abs
local tonumber = tonumber

local _M = { s = 1000, m = 60000, h = 3600000, d = 86400000, w = 604800000, y = 31557600000 }

function _M:covert(val, options)
    if val == nil then
        return nil
    end
    local t = type(val)
    if t == 'string' then
        if str_len(val) > 0 then
            return mt_floor(self:parse(val) + 0.5)
        else
            return nil
        end
    elseif t == 'number' then
        if options ~= nil and options.long ~= nil then
            return self:fmtLong(val)
        else
            return self:fmtShort(val)
        end
    else
        return nil
    end
end

-- @param  format time str
-- @return millisecond number | if input error return nil
function _M:parse(str)
    local startIdx, _, n, unit = str_find(str, '^(%-?%d*%.?%d+)%s?(%l*)$')
    if startIdx == nil then
        return nil
    end
    if (unit == nil) or (unit == '') then
        unit = 'ms'
    end
    n = tonumber(n)
    if (unit == 'years') or (unit == 'year') or (unit == 'yrs') or (unit == 'yr') or (unit == 'y') then
        return n * self.y
    elseif (unit == 'weeks') or (unit == 'week') or (unit == 'w') then
        return n * self.w
    elseif (unit == 'days') or (unit == 'day') or (unit == 'd') then
        return n * self.d
    elseif (unit == 'hours') or (unit == 'hour') or (unit == 'hrs') or (unit == 'hr') or (unit == 'h') then
        return n * self.h
    elseif (unit == 'minutes') or (unit == 'minute') or (unit == 'mins') or (unit == 'min') or (unit == 'm') then
        return n * self.m
    elseif (unit == 'seconds') or (unit == 'second') or (unit == 'secs') or (unit == 'sec') or (unit == 's') then
        return n * self.s
    elseif (unit == 'milliseconds') or (unit == 'millisecond') or (unit == 'ms') or (unit == 'ms') or (unit == 'ms') then
        return n
    else
        return nil
    end
end

-- @param  millisecond number
-- @return time in long format str
function _M:fmtLong(ms)
    local msAbs = mt_abs(ms)
    if (msAbs >= self.d) then
        return self:plural(ms, msAbs, self.d, 'day')
    end
    if (msAbs >= self.h) then
        return self:plural(ms, msAbs, self.h, 'hour')
    end
    if (msAbs >= self.m) then
        return self:plural(ms, msAbs, self.m, 'minute')
    end
    if (msAbs >= self.s) then
        return self:plural(ms, msAbs, self.s, 'second')
    end
    return _M .. ms
end

-- @param  millisecond number
-- @return time in short format str
function _M:fmtShort(ms)
    local msAbs = mt_abs(ms)
    if msAbs >= self.d then
        return mt_floor(ms / self.d + 0.5) .. 'd'
    end
    if msAbs >= self.h then
        return mt_floor(ms / self.h + 0.5) .. 'h'
    end
    if msAbs >= self.m then
        return mt_floor(ms / self.m + 0.5) .. 'm'
    end
    if msAbs >= self.s then
        return mt_floor(ms / self.s + 0.5) .. 's'
    end
    return _M .. ms
end

-- @param  millisecond number, abs millisecond, time unit's number, time unit's name
-- @return time in format str
function _M:plural(ms, msAbs, n, name)
    local pluralStr = ''
    if msAbs >= n * 1.5 then
        pluralStr = 's'
    end
    return mt_floor(ms / n + 0.5) .. ' ' .. name .. pluralStr
end

return _M
