class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show,:show_products_by_category]

  # GET /products
  # GET /products.xml
  def index
    @products = Product.all
    @products = Product.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 7
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def show_products_by_category
    category_id = params[:category_id]
    @cart = current_cart 
    session[:current_category_id] = category_id
    @products_list = []
    if Category.find_by_id(category_id).parent_id
      @products_list = Product.find_all_by_category_id(category_id)
    else
      for category in Category.find_all_by_parent_id(category_id)
        tmp = Product.find_all_by_category_id(category.id)
        unless tmp.size == 0
          @products_list.concat(tmp)
        end
      end
    end
    unless @products_list.empty?
      @products_list = @products_list.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 7
    end
    render 'products/products_list'
  end
  
  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
