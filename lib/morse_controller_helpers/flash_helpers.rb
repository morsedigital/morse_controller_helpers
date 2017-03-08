module MorseControllerHelpers
  # module FlashHelpers
  module FlashHelpers
    def flash_create_yes
      flash[:success] = "#{klass_humanized} succesfully created."
    end

    def flash_create_no
      flash[:warning] = 'Failed to create, please check the form for errors.'
    end

    def flash_destroy_yes
      flash[:notice] = "#{klass_humanized} succesfully deleted."
    end

    def flash_destroy_no
      flash[:warning] = "#{klass_humanized} failed to delete."
    end

    def flash_update_yes
      flash[:notice] = "#{klass_humanized} succesfully updated."
    end

    def flash_update_no
      flash[:warning] = 'Failed to update, please check the form for errors.'
    end

    def flash_404_error
      flash[:error] = 'Unable to locate record.'
    end
  end
end
