#encoding: utf-8
class DiscountDetailsController < ApplicationController
  before_filter :authenticate_user!
  # GET /discount_details
  # GET /discount_details.xml
  def index
    @discount_details = DiscountDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @discount_details }
    end
  end

  # GET /discount_details/1
  # GET /discount_details/1.xml
  def show
    @discount_detail = DiscountDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @discount_detail }
    end
  end

  # GET /discount_details/new
  # GET /discount_details/new.xml
  def new
    @discount_detail = DiscountDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @discount_detail }
    end
  end

  # GET /discount_details/1/edit
  def edit
    @discount_detail = DiscountDetail.find(params[:id])
  end

  # POST /discount_details
  # POST /discount_details.xml
  def create
    @discount_detail = DiscountDetail.new(params[:discount_detail])

    respond_to do |format|
      if @discount_detail.save
        format.html { redirect_to(discount_details_path, :notice => '创建成功！') }
        format.xml  { render :xml => @discount_detail, :status => :created, :location => @discount_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @discount_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /discount_details/1
  # PUT /discount_details/1.xml
  def update
    @discount_detail = DiscountDetail.find(params[:id])

    respond_to do |format|
      if @discount_detail.update_attributes(params[:discount_detail])
        format.html { redirect_to(discount_details_path, :notice => '更新成功！') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @discount_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /discount_details/1
  # DELETE /discount_details/1.xml
  def destroy
    @discount_detail = DiscountDetail.find(params[:id])
    @discount_detail.destroy

    respond_to do |format|
      format.html { redirect_to(discount_details_url) }
      format.xml  { head :ok }
    end
  end
end
