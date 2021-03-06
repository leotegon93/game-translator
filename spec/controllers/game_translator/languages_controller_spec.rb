require 'spec_helper'

describe GameTranslator::LanguagesController do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }
  let(:language) { create(:game_translator_language, name: 'Language', code: 'de') }

  before { sign_in reviser }

  describe 'GET index' do
    it 'renders the users index' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET new' do
    it 'assigns a new object to the language' do
      get :new
      assigns(:language).should be_new_record
    end

    it 'renders the new view' do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST create' do
    it 'create language with valid attributes' do
      post :create, game_translator_language: attributes_for(:game_translator_language)
      response.should redirect_to languages_path
    end

    it 'saves language to the database' do
      post :create, game_translator_language: attributes_for(:game_translator_language)
      assigns(:language).should_not be_new_record
      response.should redirect_to languages_path
    end
  end

  describe 'GET edit' do
    it 'renders the edit view' do
      get :edit, id: language.id
      response.should render_template :edit
    end

    it 'assigns a language to the language variable' do
      get :edit, id: language.id
      assigns(:language).should == language
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'redirects to the index view' do
        put :update, { id: language.id, game_translator_language: { code: 'zh-CN' } }
        response.should redirect_to languages_path
      end

      it 'changes the language attributes' do
        put :update, { id: language.id, game_translator_language: { code: 'zh-CN' } }
        language.reload
        language.code.should == 'zh-CN'
      end
    end

    context 'with invalid attributes' do
      it 'render the edit view' do
        put :update, { id: language.id, game_translator_language: { code: 'abcdef' } }
        response.should render_template :edit
      end

      it 'does not changes the language attributes' do
        put :update, { id: language.id, game_translator_language: { code: 'abcdef', name: 'Language2' } }
        language.reload
        language.name.should == 'Language'
      end
    end
  end


  describe 'DELETE destroy' do
    before do
      @english = create(:game_translator_language, name: 'Language', code: 'en')
    end

    it 'redirects to the index page' do
      delete :destroy, id: @english.id
      response.should redirect_to languages_path
    end

    it 'deletes the language' do
      expect{ delete :destroy, id: @english.id }.to change(GameTranslator::Language, :count).by(-1)
    end
  end
end