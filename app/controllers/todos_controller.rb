class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :toggle]
  
  def index
    @todos = Todo.all.order(created_at: :desc)
    @pending_todos = Todo.pending.order(created_at: :desc)
    @completed_todos = Todo.completed.order(created_at: :desc)
  end
  
  def show
  end
  
  def new
    @todo = Todo.new
  end
  
  def create
    @todo = Todo.new(todo_params)
    
    if @todo.save
      redirect_to todos_path, notice: 'TODOを作成しました。'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'TODOを更新しました。'
    else
      render :edit
    end
  end
  
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'TODOを削除しました。'
  end
  
  def toggle
    @todo.toggle_completed!
    redirect_to todos_path, notice: 'TODOの状態を更新しました。'
  end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])
  end
  
  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end