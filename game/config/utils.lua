----------------------------------------------------------------------------------------------------
-- Various utility function
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Count entries in a table
----------------------------------------------------------------------------------------------------
function length(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

----------------------------------------------------------------------------------------------------
-- Checks if a table contains a given key
----------------------------------------------------------------------------------------------------
function contain_key(values, key)
  for k, _ in pairs(values) do
    if k == key then
      return true
    end
  end
  return false
end

----------------------------------------------------------------------------------------------------
-- Checks if a table contains a given value
----------------------------------------------------------------------------------------------------
function contain_value(values, target)
  for _, v in pairs(values) do
    if v == target then
      return true
    end
  end
  return false
end

----------------------------------------------------------------------------------------------------
-- Select a command from a command table
----------------------------------------------------------------------------------------------------
function select_command(commands,choice,case)
  local current = choice

  if(type(current) == "string") then
    if(case) then current = string.upper(current) end
  end

  if( not contain_key(commands,current) ) then
    current = "~"
  end

  return commands[current]
end

----------------------------------------------------------------------------------------------------
-- Dump a table to a string
-- Thanks to https://stackoverflow.com/questions/9168058
----------------------------------------------------------------------------------------------------
function dump_table(node,name)
  local cache, stack, output = {},{},{}
  local depth = 1
  local output_str = name .. " = {\n\r"

  while true do
    local size = 0
    for k,v in pairs(node) do
      size = size + 1
    end

    local cur_index = 1
    for k,v in pairs(node) do
      if (cache[node] == nil) or (cur_index >= cache[node]) then

        if (string.find(output_str,"}",output_str:len())) then
          output_str = output_str .. ",\n\r"
        elseif not (string.find(output_str,"\n\r",output_str:len())) then
          output_str = output_str .. "\n\r"
        end

        -- This is necessary for working with HUGE tables otherwise
        -- we run out of memory using concat on huge strings
        table.insert(output,output_str)
        output_str = ""

        local key
        if (type(k) == "number" or type(k) == "boolean") then
          key = "["..tostring(k).."]"
        else
          key = "['"..tostring(k).."']"
        end

        if (type(v) == "number" or type(v) == "boolean") then
          output_str = output_str .. string.rep(' ',12*depth) .. key .. " = "..tostring(v)
        elseif (type(v) == "table") then
          output_str = output_str .. string.rep(' ',12*depth) .. key .. " = {\n\r"
          table.insert(stack,node)
          table.insert(stack,v)
          cache[node] = cur_index+1
          break
        else
          output_str = output_str .. string.rep(' ',12*depth) .. key .. " = '"..tostring(v).."'"
        end

        if (cur_index == size) then
          output_str = output_str .. "\n\r" .. string.rep(' ',12*(depth-1)) .. "}"
        else
          output_str = output_str .. ","
        end
      else
        -- close the table
        if (cur_index == size) then
          output_str = output_str .. "\n\r" .. string.rep(' ',12*(depth-1)) .. "}"
        end
      end

      cur_index = cur_index + 1
    end

    if (size == 0) then
      output_str = output_str .. "\n\r" .. string.rep(' ',12*(depth-1)) .. "}"
    end

    if (#stack > 0) then
      node = stack[#stack]
      stack[#stack] = nil
      depth = cache[node] == nil and depth + 1 or depth - 1
    else
      break
    end
  end

  -- This is necessary for working with HUGE tables otherwise
  -- we run out of memory using concat on huge strings
  table.insert(output,output_str)
  output_str = table.concat(output)

  return output_str
end
