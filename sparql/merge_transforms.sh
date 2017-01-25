#!/bin/bash

set -e

declare -a UPDATES=(
  # Remove data
  "delete_empty_lots.ru"

  # Clean literals
  "unquote_literals.ru"
  "canonicalize_organization_names.ru"
  "trim_trailing_slash_from_urls.ru"
  "prefer_https_urls.ru"
  "prefer_urls_with_protocol.ru"
  "replace_slashes_with_v.ru"

  # Clean award criteria
  "capitalize_award_criteria.ru"
  "map_award_criteria.ru"

  # Add defaults
  "default_on_czk_currency.ru"
  "default_on_czech_republic_as_country.ru"

  # Street address cleaning
  ## Do not use until <https://github.com/openlink/virtuoso-opensource/issues/415> is fixed:
  # "expand_street_address_abbreviations_trida.ru"
  # "expand_street_address_abbreviations_namesti.ru"
  # "expand_street_address_abbreviations_sidliste.ru"
  # "expand_street_address_abbreviations_bratri.ru"
  "street_address_split.ru"
  "street_address_trim_leading_ul.ru"
  "street_address_remove_ul.ru"
  "street_address_lowercase_words.ru"
  "street_address_extract_postal_code.ru"
  "address_description_extract_postal_code.ru"
  "street_address_delete_trailing_comma.ru"
  "street_address_delete_trailing_semicolon.ru"
  "street_address_space_out_numbers.ru"
  "street_address_delete_number_abbreviation_1.ru"
  "street_address_delete_number_abbreviation_2.ru"
  "parse_addresses_1.ru"
  "parse_addresses_2.ru"
  "parse_addresses_3.ru"
  "parse_addresses_4.ru"
  "delete_empty_street_address.ru"
  "delete_empty_cislo_domovni.ru"
  "delete_empty_cislo_orientacni.ru"
  "delete_empty_cislo_orientacni_pismeno.ru"
  "lowercase_orientational_number_letter.ru"
  "delete_empty_postal_code.ru"
  "delete_placeholder_address_locality.ru"
  "street_address_trim_whitespace.ru"
  "remove_street_address_duplicating_address_locality.ru"

  # Postal code cleaning
  "extract_postal_codes.ru"
  "remove_non_numeric_characters_in_postal_codes.ru"
  "replace_O_with_0_in_postal_codes.ru"
  "postal_code_pad_zeroes.ru"
  "remove_non_numeric_postal_codes.ru"

  # IČO cleaning
  "invalid_ico_trim_non_numeric_characters.ru"
  "invalid_ico_remove_empty.ru"
  "invalid_ico_remove_zero.ru"
  "invalid_ico_revalidate.ru"

  # Move properties
  "invert_is_lot_of.ru"
  "interchange_mixed_min_and_max_prices.ru"

  # Merging
  "blank_nodes_to_hash_iris_postal_addresses.ru"
  "blank_nodes_to_hash_iris_places.ru"
  "blank_nodes_to_hash_iris_concepts.ru"
  "blank_nodes_to_hash_iris_price_specifications.ru"
  "blank_nodes_to_hash_iris_projects.ru"
  "blank_nodes_to_hash_iris_criterion_weightings.ru"
  "blank_nodes_to_hash_iris_award_criteria_combinations.ru"
  "create_ico_based_iris.ru" # Needs very small page sizes, such as 20.
  "blank_nodes_to_hash_iris_organizations.ru"
  "group_organizations_by_name_and_postal_code.ru"
  "blank_nodes_to_hash_iris_tenders.ru"
  "merge_contracts_without_lots_with_their_lot.ru"
  "cast_single_lots_as_contracts.ru"
  "remove_organization_data_retrievable_from_ares.ru"
  "blank_nodes_to_hash_iris_postal_addresses_all.ru"
  "blank_nodes_to_hash_iris_concepts_all.ru" # Needs very small page sizes, such as 5.
  "blank_nodes_to_hash_iris_organizations_all.ru" # Needs very small page sizes, such as 5.

  # Reconcile code lists
  "map_procedure_types.ru"

  # Load vocabularies
  "load_pproc.ru"

  # Resolve and merge notices
  "merge_contracts_with_single_notice.ru"
  "resolve_correction_notices.ru"
  "resolve_updating_notices.ru"
  "resolve_notice_priorities_by_order.ru"
  "merge_single_contract_contracting_authorities_with_ico.ru"
  "merge_single_contract_contracting_authorities_without_ico.ru"
  "drop_conflicting_boolean_properties.ru"

  "merge_notices_with_contracts.ru"
  "move_non_notice_types.ru"
  "blank_nodes_to_hash_iris_notices.ru"
  "merge_awarded_bidders_with_the_same_name.ru"
  "remove_invalid_ico_from_organizations_with_valid_ico.ru"

  "prefer_later_award_date.ru"
  "remove_transitively_inferable_procedure_types.ru"
  "sample_procedure_type.ru"
  "sample_actual_price.ru"

  # Delete orphans
  "delete_orphaned_organizations.ru"
  "delete_orphaned_identifiers.ru"
  "delete_orphaned_places.ru"
  "delete_orphaned_postal_addresses.ru"
  "delete_orphaned_price_specifications.ru"
  "delete_orphaned_projects.ru"
  "delete_orphaned_award_criteria_combinations.ru"
  "delete_orphaned_criterion_weightings.ru"
  "delete_orphaned_concepts.ru"

  # Enrichment
  "geocode_czech_republic.ru"
  "geocode_regions_by_name.ru"
  "geocode_regions_by_nuts.ru"

  # Normalization
  "convert_eur_to_czk.ru"
  "convert_non_czk_currencies_part_1.ru" # Placeholders, need to be executed via sparql-to-csv
  "convert_non_czk_currencies_part_2.ru"
  "convert_price_ranges_to_averages.ru"
)

for update in "${UPDATES[@]}"; do
  cat $update
  echo ";"
done
