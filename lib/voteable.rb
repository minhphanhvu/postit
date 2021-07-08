# Using Concerns
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable    
  end

  def total_votes
    self.upvotes - self.downvotes
  end

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end
end

=begin
# Using normal metaprogramming
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      self.upvotes - self.downvotes
    end

    def upvotes
      self.votes.where(vote: true).size
    end

    def downvotes
      self.votes.where(vote: false).size
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end
end
=end

