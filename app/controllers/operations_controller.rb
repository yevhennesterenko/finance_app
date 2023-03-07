class OperationsController < ApplicationController
  before_action :get_category
  before_action :set_operation, only: %i[ show edit update destroy ]

  # GET /operations or /operations.json
  def index
    @operations = @category.operations.all
  end

  # GET /operations/1 or /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @categories = Category.all.map { |c| [ c.name, c.id ] }
    @operation = @category.operations.build
  end

  # GET /operations/1/edit
  def edit
    @categories = Category.all.map { |c| [ c.name, c.id ] }
  end

  # POST /operations or /operations.json
  def create
    @operation = @category.operations.build(operation_params)

    respond_to do |format|
      if @operation.save
        format.html { redirect_to category_operations_path(@category), notice: "Operation was successfully created." }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to category_operations_path(@category), notice: "Operation was successfully updated." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to category_operations_path(@category), notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def get_category
      @category = Category.find(params[:category_id]) 
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = @category.operations.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id)
    end
end
