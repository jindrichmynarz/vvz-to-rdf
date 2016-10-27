#!/bin/bash

set -e

declare -a UPDATES=(
  # Remove data
  "delete_empty_lots.ru"
  "remove_invalid.ru"

  # Clean literals
  "unquote_literals.ru"
  "canonicalize_organization_names.ru"
  "trim_trailing_slash_from_urls.ru"
  "prefer_https_urls.ru"

  # Street address cleaning
  "expand_street_address_abbreviations_trida.ru"
  "expand_street_address_abbreviations_namesti.ru"
  "expand_street_address_abbreviations_sidliste.ru"
  "expand_street_address_abbreviations_bratri.ru"
  "street_address_trim_leading_ul.ru"
  "street_address_remove_ul.ru"
  "street_address_lowercase_words.ru"
  "street_address_extract_postal_code.ru"

  # Postal code cleaning
  "extract_postal_codes.ru"
  "remove_non_numeric_characters_in_postal_codes.ru"
  "replace_O_with_0_in_postal_codes.ru"
  "postal_code_pad_zeroes.ru"
  "remove_non_numeric_postal_codes.ru"

  # Move properties
  "invert_is_lot_of.ru"
  "move_award_date_to_awarded_tender.ru"

  "reduce_on_behalf_of.ru"

  # Add defaults
  "default_on_czk_currency.ru"

  # Merging
  "blank_nodes_to_hash_iris_postal_addresses.ru"
  "merge_postal_addresses.ru"
  "blank_nodes_to_hash_iris_places.ru"
  "merge_places.ru"
  "blank_nodes_to_hash_iris_concepts.ru"
  "merge_concepts.ru"
  "blank_nodes_to_hash_iris_price_specifications.ru"
  "merge_price_specifications.ru"
  "blank_nodes_to_hash_iris_projects.ru"
  "merge_projects.ru"
  "blank_nodes_to_hash_iris_criterion_weightings.ru"
  "merge_criterion_weightings.ru"
  "blank_nodes_to_hash_iris_award_criteria_combinations.ru"
  "merge_award_criteria_combinations.ru"
  "create_ico_based_iris.ru"
  "blank_nodes_to_hash_iris_organizations.ru"
  "merge_organizations.ru"
  "domains_to_ico.ru"
  "group_organizations_by_name_and_postal_code.ru"
  "blank_nodes_to_hash_iris_tenders.ru"
  "merge_tenders.ru"
  "merge_contracts_without_lots_with_their_lot.ru"
  "cast_single_lots_as_contracts.ru"
  "remove_organization_data_retrievable_from_ares.ru"
)

for update in "${UPDATES[@]}"; do
  cat $update
  echo ";"
done
