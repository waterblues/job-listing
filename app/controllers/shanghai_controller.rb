class ShanghaiController < ApplicationController
    before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

    before_filter :validate_search_key, :only => [:search]

    layout "shanghai"

    def index
      @jobs = case params[:order]
        when 'by_lower_bound'
          Job.where(:address => "上海").published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 15)
        when 'by_upper_bound'
          Job.where(:address => "上海").published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 15)
        else
          Job.where(:address => "上海").published.recent.paginate(:page => params[:page], :per_page => 15)
        end
    end



    def new
      @job = Job.new
    end

    def create
      @job = Job.new(job_params)
      if @job.save
          redirect_to shanghai_index_path
      else
          render :new
      end
     end

     def show
       @job = Job.find(params[:id])
     end

     def edit
       @job = Job.find(params[:id])
     end

     def update
       @job = Job.find(params[:id])
       if @job.update(job_params)
         redirect_to shanghai_index_path, notice: '编辑成功'
       else
         render :edit
       end
      end

     def destroy
       @job = Job.find(params[:id])
       @job.destroy
         redirect_to shanghai_index_path, alert:'职位已删除'
     end

     def search
       name = params[:q]
       @jobs = Job.published.where("title LIKE '%#{name}%'")
     end

     protected

     def validate_search_key
       @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
       @search_criteria = search_criteria(@query_string)
     end

     def search_criteria(query_string)
       { :title_or_description_cont => query_string}
     end

     private

     def job_params
       params.require(:job).permit(:title, :description,:wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :require_skill, :company, :address)
     end





  end
