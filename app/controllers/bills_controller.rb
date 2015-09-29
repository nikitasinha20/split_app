class BillsController < ApplicationController

  def new
    @bill = Bill.new
    @group = Group.find(params[:group_id])
  end

  #def edit
  #  @bill = Bill.find(params[:id])
  #  @group = Group.find(params[:group_id])
  #end

  #def show
  #  @bill = Bill.find(params[:id])
  #end

  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to :controller => 'groups', :action => 'show', :id => params[:group_id] }
        format.json { render json: @group, status: :created, location: [@bill] }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #  respond_to do |format|
  #    if @bill.update(bill_params)
  #      format.html  { redirect_to :controller => 'groups', :action => 'show', :group_id => 'params[:group_id]', :id => 'params[:id]'    }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @bill.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  #def destroy
  #  @bill.destroy
  # respond_to do |format|
  #   format.html { redirect_to :controller => 'groups' :action => 'home' }
  #    format.json { head :no_content }
  # end
  #end

  private
    def set_bill
      @bill = @group.bills.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:details, :amount, :paid_by, :group_id)
    end
end
