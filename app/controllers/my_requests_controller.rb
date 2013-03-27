# -*- coding: utf-8 -*-
class MyRequestsController < ApplicationController

  def latest
    @my_request = MyRequest.latest
    @feeds = if params[:keyword].present?
               @my_request.feeds.where(["content LIKE ?", "%#{params[:keyword]}%"])
             else
               @my_request.feeds
             end
    render :show
  end

  # GET /my_requests
  # GET /my_requests.json
  def index
    @my_requests = MyRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_requests }
    end
  end

  # GET /my_requests/1
  # GET /my_requests/1.json
  def show
    @my_request = MyRequest.find(params[:id])
    @feeds = @my_request.feeds

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @my_request }
    end
  end

  # GET /my_requests/new
  # GET /my_requests/new.json
  def new
    @my_request = MyRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @my_request }
    end
  end

  # GET /my_requests/1/edit
  def edit
    @my_request = MyRequest.find(params[:id])
  end

  # POST /my_requests
  # POST /my_requests.json
  def create
    @my_request = MyRequest.new(params[:my_request])

    respond_to do |format|
      if @my_request.save
        format.html { redirect_to @my_request, notice: 'My request was successfully created.' }
        format.json { render json: @my_request, status: :created, location: @my_request }
      else
        format.html { render action: "new" }
        format.json { render json: @my_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /my_requests/1
  # PUT /my_requests/1.json
  def update
    @my_request = MyRequest.find(params[:id])

    respond_to do |format|
      if @my_request.update_attributes(params[:my_request])
        format.html { redirect_to @my_request, notice: 'My request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @my_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_requests/1
  # DELETE /my_requests/1.json
  def destroy
    @my_request = MyRequest.find(params[:id])
    @my_request.destroy

    respond_to do |format|
      format.html { redirect_to my_requests_url }
      format.json { head :no_content }
    end
  end
end
