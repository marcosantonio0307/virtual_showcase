class ProductsController < ApplicationController
	before_action :authenticate_user!, only:[:index, :myproducts, :new, :create, :edit, :update, :destroy, :show]
	def myproducts
		user = User.find(params[:user])
		@products = user.products

		render json: @products
	end

	def index
		@products = current_user.products
	end

	def new
		@product = Product.new
		@categories = current_user.categories
		@categories = @categories.where(active: true)
		@categories = @categories.map{|c| c.name}
	end

	def create
		values = params.require(:product).permit!
		if params[:product][:user_id].to_i == current_user.id
			if params[:product][:category_id] != nil
				category = Category.where(name: params[:product][:category_id]).first.id
				params[:product][:category_id] = category.to_i
			end
			if params[:product][:active] == 'sim'
				params[:product][:active] = true
			else
				params[:product][:active] = false
			end
			@product = Product.create values
			if @product.save
				redirect_to root_path, notice: 'Produto Salvo!'
			else
				render :new
			end
		else
			redirect_to root_path, notice: 'Operação rejeitada!'
		end
	end

	def edit
		@product = Product.find(params[:id])
		@categories = current_user.categories.map{|c| c.name}
	end

	def update
		@product = Product.find(params[:id])
		values = params.require(:product).permit!
		if params[:product][:user_id].to_i == current_user.id
			if params[:product][:category_id] != nil
				category = Category.where(name: params[:product][:category_id]).first.id
				params[:product][:category_id] = category.to_i
			end
			if params[:product][:active] == 'sim'
				params[:product][:active] = true
			else
				params[:product][:active] = false
			end
			@product.update values
			if @product.save
				redirect_to root_path, notice: 'Produto Atualizado!'
			else
				render :edit
			end
		else
			redirect_to root_path, notice: 'Operação rejeitada!'
		end
	end

	def destroy
		products = current_user.products.map{|p| p.id}
		if products.include?(params[:id].to_i)
			Product.destroy params[:id]
			redirect_to root_path, notice: 'Produto Excluído!'
		else
			redirect_to root_path, notice: 'Você não pode excluir esse produto!'
		end
	end

	def show
		@product = Product.find(params[:id])
	end
end