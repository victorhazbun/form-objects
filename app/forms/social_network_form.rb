class SocialNetworkForm
  include ActiveModel::Model
  include ActiveModel::Serialization
  
  attr_accessor(
    :id,
    :url
  )

  validates :url, presence: true

  def attributes
    { 
      'id' => nil,
      'url' => nil
    }
  end
end
