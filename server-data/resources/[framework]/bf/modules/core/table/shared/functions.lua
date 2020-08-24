M('string')

table.sizeOf = function(t)

  local count = 0

  for k,v in pairs(t) do
    count = count + 1
  end

  return count

end

table.isArray = function(t)

  local keys = {}

  for k,v in pairs(t) do

    local num = tonumber(k)

    if num ~= k then
      return false
    end

    table.insert(keys, num)

  end

  table.sort(keys, function(a, b) return a < b end)

  for i=1, #keys, 1 do
    if keys[i] ~= i then
      return false
    end
  end

  return true

end

table.indexOf = function(t, val)

  for i=1, #t, 1 do
    if t[i] == val then
      return i
    end
  end

  return -1

end

table.lastIndexOf = function(t, val)

  for i=#t, 1, -1 do
    if t[i] == val then
      return i
    end
  end

  return -1
end

table.find = function(t, cb)

  for i=1, #t, 1 do
    if cb(t[i]) then
      return t[i]
    end
  end

  return nil

end

table.findIndex = function(t, cb)

  for i=1, #t, 1 do
    if cb(t[i]) then
      return i
    end
  end

  return -1
end

table.filter = function(t, cb)

  local newTable = {}

  for i=1, #t, 1 do
    if cb(t[i]) then
      table.insert(newTable, t[i])
    end
  end

  return newTable

end

table.map = function(t, cb)

  local newTable = {}

  for i=1, #t, 1 do
    newTable[i] = cb(t[i], i)
  end

  return newTable

end

table.reverse = function(t)

  local newTable = {}

  for i=#t, 1, -1 do
    table.insert(newTable, t[i])
  end

  return newTable

end

table.clone = function(t)

  if type(t) ~= 'table' then
    return t
  end

  local copy = {}

  for k,v in pairs(t) do
    copy[k] = table.clone(v)
  end

  return copy

end

table.concat = function(t1, t2)

  if type(t2) == 'string' then
    local separator = t2
    return table.join(t1, separator)
  end

  local t3 = table.clone(t1)

  for i=1, #t2, 1 do
    table.insert(t3, t2[i])
  end

  return t3

end

table.join = function(t, sep)

  local sep = sep or ','
  sep       = tostring(sep)
  local str = ''

  for i=1, #t, 1 do

    if i > 1 then
      str = str .. sep
    end

    str = str .. tostring(t[i])

  end

  return str

end

table.merge = function(t1, t2)

  local t3 = {}

  for k,v in pairs(t1) do
    if type(v) == 'table' then
      t3[k] = table.merge(v, t2[k] or {})
    else
      t3[k] = v
    end
  end

  for k,v in pairs(t2) do
    if type(v) == 'table' then
      t3[k] = table.merge(v, t1[k] or {})
    else
      t3[k] = v
    end
  end

  return t3

end

table.by = function(t, k)

  local t2 = {}

  for i=1, #t, 1 do
    local entry = t[i]
    local val   = entry[k]

    if val ~= nil then
      t2[val] = entry
    end

  end

  return t2

end

table.get = function(t, path)

  local split = string.split(path, '.')
  local obj   = t

  for i=1, #split, 1 do

    local key    = split[i]
    local keyNum = tonumber(key)

    if keyNum ~= nil then
      key = keyNum
    end

    obj = obj[key]

  end

  return obj

end

table.set = function(t, path, v)

  local split = string.split(path, '.')
  local obj   = t

  for i=1, #split, 1 do

    local key    = split[i]
    local keyNum = tonumber(key)

    if keyNum ~= nil then
      key = keyNum
    end

    if i == #split then
      obj[key] = v
    else
      obj = obj[key]
    end

  end

end

table.keys = function(t)

  local keys = {}

  for k,v in pairs(t) do
    keys[#keys + 1] = k
  end

  return keys

end

table.values = function(t)

  local values = {}

  for k,v in pairs(t) do
    values[#values + 1] = v
  end

  return values

end