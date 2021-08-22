module V1
  module Auth
    class TasksController < ApplicationController
      def index
        render json: current_user.tasks, status: 200
      end

      def create
        @task = Task.new(task_params)
        if @task.save
          render json: "create new task.\n", status: 200
        else
          render json: "fail to create. \n", status: 500
        end
      end
      
    end
  end
end
