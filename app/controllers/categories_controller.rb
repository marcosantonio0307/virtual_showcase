class CategoriesController < ApplicationController
	before_action :authenticate_user!

	def index
		@categories = current_user.categories
	end

	def new
		@category = Category.new
	end

	def create
		values = params.require(:category).permit!
		if params[:category][:user_id].to_i == current_user.id
			if params[:category][:active] == 'sim'
				params[:category][:active] = true
			else
				params[:category][:active] = false
			end
			@category = Category.new values
			if @category.save
				redirect_to categories_path, notice: 'Categoria salva!'
			else
				render :new
			end
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		values = params.require(:category).permit!
		@category = Category.find(params[:id])
		if params[:category][:user_id].to_i == current_user.id
			if params[:category][:active] == 'sim'
				params[:category][:active] = true
			else
				params[:category][:active] = false
			end
			@category.update values
			if @category.save
				redirect_to categories_path, notice: 'Categoria atualizada!'
			else
				render :new
			end
		end
	end
end
