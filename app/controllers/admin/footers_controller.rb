class Admin::FootersController < AdminController
  before_action :set_admin_footer, only: [:show, :edit, :update, :destroy]

  # GET /admin/footers
  # GET /admin/footers.json
  def index
    @admin_footers = Admin::Footer.all
  end

  # GET /admin/footers/1
  # GET /admin/footers/1.json
  def show
  end

  # GET /admin/footers/new
  def new
    @admin_footer = Admin::Footer.new
  end

  # GET /admin/footers/1/edit
  def edit
  end

  # POST /admin/footers
  # POST /admin/footers.json
  def create
    @admin_footer = Admin::Footer.new(admin_footer_params)

    respond_to do |format|
      if @admin_footer.save
        format.html { redirect_to @admin_footer, notice: 'Footer was successfully created.' }
        format.json { render :show, status: :created, location: @admin_footer }
      else
        format.html { render :new }
        format.json { render json: @admin_footer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/footers/1
  # PATCH/PUT /admin/footers/1.json
  def update
    respond_to do |format|
      if @admin_footer.update(admin_footer_params)
        format.html { redirect_to @admin_footer, notice: 'Footer was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_footer }
      else
        format.html { render :edit }
        format.json { render json: @admin_footer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/footers/1
  # DELETE /admin/footers/1.json
  def destroy
    @admin_footer.destroy
    respond_to do |format|
      format.html { redirect_to admin_footers_url, notice: 'Footer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_footer
      @admin_footer = Admin::Footer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_footer_params
      params.require(:admin_footer).permit(:title, :locale, :about_link, :about_link_name, :email, :email_name, :terms_of_usage_link, :terms_of_usage_link_name, :info, :copyright)
    end
end
