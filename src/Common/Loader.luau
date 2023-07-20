local Loader = {}

function Loader.LoadChildren(instance)
    local children = {}

    for _, child in instance:GetChildren() do
        children[child.Name] = require(child)
    end

    return children
end

return Loader