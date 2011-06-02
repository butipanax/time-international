#enconding: utf-8
class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_admin_activity
   
  def index
    @users = User.all
    @users = @users.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 12
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def show
    
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end


  def edit
    @user = User.find(params[:id])
    @profile = @user.profile || @user.build_profile
  end
  
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@rZZole, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
   end
   

  def update
    @user = User.find(params[:id])
    @profile = @user.profile || @user.build_profile 
    respond_to do |format|
      if (@user.update_attributes(params[:user]) and @profile.update_attributes(params[:user][:profile_attributes]))
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def new_users_search
    render "users/users_search_list"
  end
  
  def users_search
    if params[:name] == 'name'
      @profiles = Profile.where("name like ?", "#{params[:name_search_field]}%")
      @users = @profiles.map{|p|p.user}
    end
    if params[:name] == 'wangwang'
      @profiles = Profile.where("wangwang_number like ?", "#{params[:wangwang_search_field]}%")
      @users = @profiles.map{|p|p.user}    
    end
    if params[:name] == 'email'      
      @users = User.where("email like ?", "#{params[:email_search_field]}%")
      @profiles = @users.map{|u|u.profile}
    end
    if @users
     @users = @users.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 12
      render "index"
    else 
      redirect_to(users_searching_url)
    end
  end
 
  end

