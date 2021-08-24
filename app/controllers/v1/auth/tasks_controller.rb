module V1
  module Auth
    class TasksController < ApplicationController
      def index
        render json: current_user.tasks, status: 200
      end

      def create
        @task = Task.new(task_params)
        @task.user_id = current_user.id
        if @task.save
          render json: "create new task", status: 200
        else
          render json: "fail to create", status: 500
        end
      end

      private

        def task_params
          params.require(:task_params).permit(:name,:description,:user_id)
        end
    end
  end
end
