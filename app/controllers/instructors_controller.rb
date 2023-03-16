class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response

    def index
        render json: Instructor.all
    end

    def show
        instructor =  Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor
            render json: instructor, status: :created
        else
            render json: {errors: ["validation have not been met"] }, status: :unprocessable_entity
        end
    end

    def update
        instructor =  Instructor.find_by(id: params[:id])
        instructor.update(instructor_params)
        render json: instructor
    end

    def destroy
        instructor =  Instructor.find_by(id: params[:id]).detroy
        render json: instructor
    end




    private

    def render_invalid_response
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def instructor_params
        params.permit(:name)
    end
end
