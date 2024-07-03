class CategoriesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render :index, locals: { categories: }
  end

  def show
    render :show, locals: { doctors:, category: }
  end

  def new
    category = Category.new
    render :new, locals: { category: }
  end

  def edit
    render :edit, locals: { category: }
  end

  def create
    category = Category.new(category_params)

    if category.save
      redirect_to categories_path, flash: { success: I18n.t('flash_messages.categories.created') }
    else
      flash.now[:danger] = I18n.t('flash_messages.categories.not_created')
      render :new, locals: { category: }
    end
  end

  def update
    if category.update(category_params)
      redirect_to categories_path, flash: { success: I18n.t('flash_messages.categories.updated') }
    else
      flash.now[:danger] = I18n.t('flash_messages.categories.not_updated')
      render :edit, locals: { category: }
    end
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def categories
    Category.order_by_name
  end

  def doctors
    Doctor.order_by_email.where(category:)
  end

end
