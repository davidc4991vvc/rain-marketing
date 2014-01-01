class Market::TodoItemsController < Market::ApplicationController
  before_action :set_market_todo_item, only: [:show, :edit, :update, :destroy]

  # GET /market/todo_items
  # GET /market/todo_items.json
  def index
    @market_todo_items = Market::TodoItem.all
  end

  # GET /market/todo_items/1
  # GET /market/todo_items/1.json
  def show
  end

  # GET /market/todo_items/new
  def new
    @market_todo_item = Market::TodoItem.new
  end

  # GET /market/todo_items/1/edit
  def edit
  end

  # POST /market/todo_items
  # POST /market/todo_items.json
  def create
    @market_todo_item = Market::TodoItem.new(market_todo_item_params)

    respond_to do |format|
      if @market_todo_item.save
        format.html { redirect_to @market_todo_item, notice: 'Todo item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @market_todo_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @market_todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market/todo_items/1
  # PATCH/PUT /market/todo_items/1.json
  def update
    respond_to do |format|
      if @market_todo_item.update(market_todo_item_params)
        format.html { redirect_to @market_todo_item, notice: 'Todo item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @market_todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market/todo_items/1
  # DELETE /market/todo_items/1.json
  def destroy
    @market_todo_item.destroy
    respond_to do |format|
      format.html { redirect_to market_todo_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_todo_item
      @market_todo_item = Market::TodoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_todo_item_params
      params.require(:market_todo_item).permit(:site_id, :parent_id, :title, :description, :priority, :status, :assigned_to, :started_at, :finished_at)
    end
end
