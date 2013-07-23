class GameTranslator::UserController < ApplicationController
	def index
		@users = GameTranslator::User.all
	end

	def new
		@user = GameTranslator::User.new
	end

	def create
		@user = GameTranslator::User.new(params[:game_translator_user])
		if @user.save
			flash[:success] = 'Cadastrado com sucesso!'
			redirect_to game_translator_user_index_path
		else
			render action: 'new'
		end
	end

	def edit
		@user = GameTranslator::User.find(params[:id])
	end

	def upadte
		@user = GameTranslator::User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:sucess] = 'Cadastro atualizado com sucesso!'
			redirect_to game_translator_user_index_path
		else
			render action: :edit
		end
	end

	def destroy
		user = GameTranslator::User.find(params[:id])
		if user.destroy
			flash[:sucess] = 'Cadastro deletado!'
			redirect_to game_translator_user_index_path
		else
			render action: :edit
		end
	end
end