  ItemType Load (0.2ms)  
  SELECT "item_types".* FROM "item_types"
  MetadataSet Load (0.1ms)  
  SELECT "metadata_sets".* FROM "metadata_sets" INNER JOIN "item_types_metadata_sets" ON "metadata_sets"."id" = "item_types_metadata_sets"."metadata_set_id" WHERE "item_types_metadata_sets"."item_type_id" = $1  [["item_type_id", 1]]
  MetadataField Load (0.1ms)  
  SELECT "metadata_fields".* FROM "metadata_fields" WHERE "metadata_fields"."metadata_set_id" = $1  [["metadata_set_id", 1]]
  MetadataSet Load (0.1ms)  
  SELECT "metadata_sets".* FROM "metadata_sets" INNER JOIN "item_types_metadata_sets" ON "metadata_sets"."id" = "item_types_metadata_sets"."metadata_set_id" WHERE "item_types_metadata_sets"."item_type_id" = $1  [["item_type_id", 2]]
  CACHE (0.0ms)  
  SELECT "metadata_fields".* FROM "metadata_fields" WHERE "metadata_fields"."metadata_set_id" = $1  [["metadata_set_id", 1]]
  MetadataField Load (0.2ms)  
  SELECT "metadata_fields".* FROM "metadata_fields" WHERE "metadata_fields"."metadata_set_id" = $1  [["metadata_set_id", 2]]
