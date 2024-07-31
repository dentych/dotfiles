local M = {}

function M.merge(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end
---
---@param name string
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
	local plugin = M.get_plugin(name)
	path = path and "/" .. path or ""
	return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
	return M.get_plugin(plugin) ~= nil
end

return M
