module MorseControllerHelpers
  # module FlashHelpers
  module CrudHelpers
    def create
      @current_instance = klass.new(params_resource)
      if current_instance.save
        flash_create_yes
        redirect_to path_edit(current_instance)
      else
        flash_create_no
        render("#{resource_symbols}/new")
      end
    end

    def destroy
      if current_instance.destroy
        flash_destroy_yes
      else
        flash_destroy_no
      end
      redirect_to path_index
    end

    def edit; end

    def index; end

    def new
      @current_instance = klass.new
    end

    def show; end

    def update
      if current_instance.update_attributes(params_resource)
        flash_update_yes
        redirect_to path_edit
      else
        flash_update_no
        render("#{resource_symbols}/edit")
      end
    end
  end
end
