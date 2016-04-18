# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_151_025_115_009) do
  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.string 'source'
    t.string 'author'
    t.datetime 'pubDate'
    t.string 'summary'
    t.string 'link'
    t.string 'imageURL'
    t.datetime 'created_at',                 null: false
    t.datetime 'updated_at',                 null: false
    t.float 'weight', default: 0.0
    t.boolean 'modified', default: false
  end

  create_table 'taggings', force: :cascade do |t|
    t.integer 'tag_id'
    t.integer 'taggable_id'
    t.string 'taggable_type'
    t.integer 'tagger_id'
    t.string 'tagger_type'
    t.string 'context', limit: 128
    t.datetime 'created_at'
  end

  add_index 'taggings', %w(tag_id taggable_id taggable_type context tagger_id tagger_type), name: 'taggings_idx', unique: true
  add_index 'taggings', %w(taggable_id taggable_type context), name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
  end

  add_index 'tags', ['name'], name: 'index_tags_on_name', unique: true

  create_table 'user_articles', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.integer 'article_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'firstname'
    t.string 'lastname'
    t.string 'username'
    t.string 'email'
    t.string 'bio'
    t.boolean 'isSubscribed', default: false
    t.datetime 'tsOld'
    t.datetime 'tsRecent'
    t.datetime 'created_at',                      null: false
    t.datetime 'updated_at',                      null: false
    t.string 'password_digest'
    t.text 'recvd_articles'
  end
end