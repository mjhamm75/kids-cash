class KidsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  # GET /kids
  # GET /kids.json
  def index
    @kids = Kid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kids }
    end
  end

  # GET /kids/1
  # GET /kids/1.json
  def show
    @kid = Kid.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kid }
    end
  end

  # # GET /kids/new
  # # GET /kids/new.json
  # def new
  #   @kid = Kid.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @kid }
  #   end
  # end

  # # GET /kids/1/edit
  # def edit
  #   @kid = Kid.find(params[:id])
  # end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(params[:kid])

    respond_to do |format|
      if @kid.save
        format.html { redirect_to kids_path, notice: 'Kid was successfully created.' }
        format.json { render json: @kid, status: :created, location: @kid }
      else
        format.html { render action: "new" }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PUT /kids/1
  # # PUT /kids/1.json
  # def update
  #   @kid = Kid.find(params[:id])

  #   respond_to do |format|
  #     if @kid.update_attributes(params[:kid])
  #       format.html { redirect_to @kid, notice: 'Kid was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @kid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid = Kid.find(params[:id])
    @kid.destroy

    respond_to do |format|
      format.html { redirect_to kids_url }
      format.json { head :no_content }
    end
  end

  def add_transaction
    @kid = Kid.find_by_name(params[:name])
    @kid.transactions.create!(:amount => params[:amount].to_f, :comment => params[:comment])

    # redirect_to kids_url
    @kid[:total] = @kid.total

    respond_to do |format|
      format.json { render json: @kid}
    end
  end

  def add_kid
    balance = params[:balance].to_f
    balance = number_with_precision(balance, :precision => 2)
    name = params[:name].strip
    @kid = Kid.create!(:name => name)
    @kid.transactions.create!(:amount => balance, :comment => "Initial Balance")
    @kid[:balance] = balance
    respond_to do |format|
      format.json { render json: @kid }
    end
  end
end
