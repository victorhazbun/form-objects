class UpdateUserWithSocialNetworksForm
  include ActiveModel::Model
  
  attr_accessor(
    :success, # Sucess is just a boolean
    :user, # A user instance
    :user_name, # The user name
    :social_networks, # The user social networks
  )

  validates :user_name, presence: true
  validate :all_social_networks_valid

  def initialize(attributes={})
    super
    # Setup the default user name
    @user_name ||= user.name
  end

  def save
    ActiveRecord::Base.transaction do
      begin
        # Valid will setup the Form object errors
        if valid?
          persist!
          @success = true
        else
          @success = false
        end
      rescue => e
				self.errors.add(:base, e.message)
				@success = false
      end
    end
  end

  # This method will be used in the form
  # remember that `fields_for :social_networks` will ask for this method 
  def social_networks_attributes=(social_networks_params)
    @social_networks ||= []
    social_networks_params.each do |_i, social_network_params|
      @social_networks.push(SocialNetworkForm.new(social_network_params))
    end
  end

  private

  # Updates the user and its social networks
  def persist!
    user.update!({
      name: user_name, 
      social_networks_attributes: build_social_networks_attributes
    })
  end

  # Builds an array of hashes (social networks attributes)
  def build_social_networks_attributes
    social_networks.map do |social_network|
      social_network.serializable_hash
    end
  end

  # Validates all the social networks
  # using the social network form object,
  # which has its own validations
  # we are going to pass those validations errors
  # to this object errors.
  def all_social_networks_valid
    social_networks.each do |social_network|
      next if social_network.valid?
      social_network.errors.full_messages.each do |full_message|
        self.errors.add(:base, "Social Network error: #{full_message}")
      end
    end
    throw(:abort) if errors.any?
  end
end