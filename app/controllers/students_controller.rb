class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response

    def index
        render json: Student.all
    end

    def show
        student =  Student.find_by(id: params[:id])
        if student
            render json: student
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student
            render json: student, status: :created
        else
            render json: {errors: ["validation have not been met"] }, status: :unprocessable_entity
        end
    end

    def update
        student =  Student.find_by(id: params[:id])
        student.update(student_params)
        render json: student
    end

    def destroy
        student =  Student.find_by(id: params[:id]).destroy
        render json: student
    end




    private

    def render_invalid_response
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
