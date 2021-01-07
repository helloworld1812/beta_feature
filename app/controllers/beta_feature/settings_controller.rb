require_dependency "beta_feature/application_controller"

module BetaFeature
  class SettingsController < ApplicationController
    before_action :set_object

    rescue_from ActiveRecord::RecordNotFound do |e|
      msg = "Couldn't find this record: #{params[:object_class]}/#{params[:object_id]}"
      render json: { error: msg }, status: :not_found
    end

    # GET /beta_feature/:object_class/:object_id/setting
    def show
      betas = {}
      BetaFeature.all_betas.keys.map do |key|
        betas[key] = @object.all_betas.include?(key) ? true : false
      end

      render json: {
        object_class: @object_class,
        object_id: @object_id,
        betas: betas
      }
    end

    # PUT /beta_feature/:object_class/:object_id/setting 
    # Params:
    # {
    #   betas: {
    #     custom_domain: true,
    #     dark_mode: false,
    #     ux_improvement_2021: true
    #   }
    # }
    def update
      betas = params.permit![:betas]

      enabled_betas = betas.select {|k, v| v.to_s == "true"}.keys
      disabled_betas = betas.select {|k, v| v.to_s == "false"}.keys

      @object.enable_beta!(*enabled_betas) if enabled_betas.present?
      @object.remove_beta!(*disabled_betas) if disabled_betas.present?

      betas = {}
      BetaFeature.all_betas.keys.map do |key|
        betas[key] = @object.all_betas.include?(key) ? true : false
      end

      render json: {
        object_class: @object_class,
        object_id: @object_id,
        betas: betas
      } 
    end

    private

    def set_object
      @object_class = params.require(:object_class)
      @object_id = params.require(:object_id)

      @klass = @object_class.constantize 
      @object = @klass.find(@object_id)
    rescue NameError
      msg = "class '#{params[:object_class]}' does not exist."
      render json: { error: msg}, status: :unprocessable_entity
    end
  end
end
