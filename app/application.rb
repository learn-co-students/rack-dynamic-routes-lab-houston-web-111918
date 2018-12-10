class Application
    
    @@items = [Item.new("Item1", "$1.00"), Item.new("Item2", "$2.00"), Item.new("Item3","$3.00")]

    def call(env)
        req = Rack::Request.new(env)
        resp = Rack::Response.new
        
            if req.path.match(/items/)

                item_name = req.path.split("/items/").last
                item_instance = @@items.find{|i| i.name == item_name}

                if item_instance 
                    resp.write item_instance.price
                else
                    resp.status = 400
                    resp.write "Item not found"
                    
                end

            else
                resp.status = 404
                resp.write "Route not found"
            end

        resp.finish
    end
end