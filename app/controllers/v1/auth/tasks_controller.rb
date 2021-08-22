module V1
  module Auth
    class TasksController < V1::Auth::ApplicationController
      def index
        render json: current_user.tasks, status: 200
      end
    end
  end
end
