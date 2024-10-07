module MyModule::SkillVerification {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a skill endorsement.
    struct SkillEndorsement has store, key {
        endorser: address,         // Address of the person endorsing the skill
        endorsed: address,         // Address of the person being endorsed
        skill_name: vector<u8>,    // Name of the endorsed skill
    }

    /// Function to endorse a user's skill.
    public fun endorse_skill(endorser: &signer, endorsed: address, skill_name: vector<u8>) {
        let endorsement = SkillEndorsement {
            endorser: signer::address_of(endorser),
            endorsed,
            skill_name,
        };
        move_to(endorser, endorsement);
    }

    /// Function to verify if a user has been endorsed for a particular skill.
    public fun verify_skill(endorser_address: address, skill_name: vector<u8>, endorsed_address: address) acquires SkillEndorsement {
        let endorsement = borrow_global<SkillEndorsement>(endorser_address);

        // Ensure the endorsement matches the provided skill and endorsed person
        assert!(endorsement.endorsed == endorsed_address, 1);
        assert!(endorsement.skill_name == skill_name, 2);
    }
}
