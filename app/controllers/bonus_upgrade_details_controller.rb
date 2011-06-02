#encoding: utf-8
class BonusUpgradeDetailsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_activity
  # GET /bonus_upgrade_details
  # GET /bonus_upgrade_details.xml
  def index
    @bonus_upgrade_details = BonusUpgradeDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bonus_upgrade_details }
    end
  end

  # GET /bonus_upgrade_details/1
  # GET /bonus_upgrade_details/1.xml
  def show
    @bonus_upgrade_detail = BonusUpgradeDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bonus_upgrade_detail }
    end
  end

  # GET /bonus_upgrade_details/new
  # GET /bonus_upgrade_details/new.xml
  def new
    @bonus_upgrade_detail = BonusUpgradeDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bonus_upgrade_detail }
    end
  end

  # GET /bonus_upgrade_details/1/edit
  def edit
    @bonus_upgrade_detail = BonusUpgradeDetail.find(params[:id])
  end

  # POST /bonus_upgrade_details
  # POST /bonus_upgrade_details.xml
  def create
    @bonus_upgrade_detail = BonusUpgradeDetail.new(params[:bonus_upgrade_detail])

    respond_to do |format|
      if @bonus_upgrade_detail.save
        format.html { redirect_to(@bonus_upgrade_detail, :notice => '创建成功！') }
        format.xml  { render :xml => @bonus_upgrade_detail, :status => :created, :location => @bonus_upgrade_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bonus_upgrade_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bonus_upgrade_details/1
  # PUT /bonus_upgrade_details/1.xml
  def update
    @bonus_upgrade_detail = BonusUpgradeDetail.find(params[:id])

    respond_to do |format|
      if @bonus_upgrade_detail.update_attributes(params[:bonus_upgrade_detail])
        format.html { redirect_to(@bonus_upgrade_detail, :notice => '更新成功！') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bonus_upgrade_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bonus_upgrade_details/1
  # DELETE /bonus_upgrade_details/1.xml
  def destroy
    @bonus_upgrade_detail = BonusUpgradeDetail.find(params[:id])
    @bonus_upgrade_detail.destroy

    respond_to do |format|
      format.html { redirect_to(bonus_upgrade_details_url) }
      format.xml  { head :ok }
    end
  end
end
