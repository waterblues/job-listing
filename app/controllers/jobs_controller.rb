class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_filter :validate_search_key, :only => [:search]
  before_action :find_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
      when 'by_upper_bound'
        Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
      else
        Job.published.recent.paginate(:page => params[:page], :per_page => 10)
      end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def show
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: '编辑成功'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, alert:'职位已删除'
  end

  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 15 )
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_or_description_or_company_or_address_or_many_kind_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:title, :description,:wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :require_skill, :company, :address, :many_kind, :experience, :education)
  end

  def find_job
    @job = Job.find(params[:id])
  end
end
