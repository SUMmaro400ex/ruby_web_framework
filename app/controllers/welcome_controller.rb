module Controllers
  class WelcomeController < Kwypper::Controller

    # add_routes "GET /welcome/index" => :index
    # add_routes "GET /index" => :index

    def index
      @data = params[:param]
      @data2 = params[:foo]

      render :index
    end

    def new
      render :new
    end

  end
end


