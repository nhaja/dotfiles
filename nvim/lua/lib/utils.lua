function find_file(path, name)
	local lfs = require("lfs")
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local full_path = path .. "/" .. file
			local attr = lfs.attributes(full_path)
			if attr.mode == "file" and file == name then
				return full_path
			elseif attr.mode == "directory" then
				local result = find_file(full_path, name)
				if result then
					return result
				end
			end
		end
	end
	return nil
end
