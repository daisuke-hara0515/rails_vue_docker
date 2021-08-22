class TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]
  # リクエストしてきたユーザーを認証する
  before_action :authenticate_v1_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    render json: current_user.tasks, status: 200
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    # リダイレクト先のURL(@task)の設定を削除する
    if @task.save
      render :show, status: :created # location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      render :show, status: :ok, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.permit(:name, :description).merge(user: current_v1_user)
    end
end
