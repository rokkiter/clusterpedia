//go:build !ignore_autogenerated
// +build !ignore_autogenerated

// Code generated by deepcopy-gen. DO NOT EDIT.

package v1alpha1

import (
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *BaseReferenceResourceTemplate) DeepCopyInto(out *BaseReferenceResourceTemplate) {
	*out = *in
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new BaseReferenceResourceTemplate.
func (in *BaseReferenceResourceTemplate) DeepCopy() *BaseReferenceResourceTemplate {
	if in == nil {
		return nil
	}
	out := new(BaseReferenceResourceTemplate)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterImportPolicy) DeepCopyInto(out *ClusterImportPolicy) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterImportPolicy.
func (in *ClusterImportPolicy) DeepCopy() *ClusterImportPolicy {
	if in == nil {
		return nil
	}
	out := new(ClusterImportPolicy)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ClusterImportPolicy) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterImportPolicyList) DeepCopyInto(out *ClusterImportPolicyList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]ClusterImportPolicy, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterImportPolicyList.
func (in *ClusterImportPolicyList) DeepCopy() *ClusterImportPolicyList {
	if in == nil {
		return nil
	}
	out := new(ClusterImportPolicyList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *ClusterImportPolicyList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterImportPolicySpec) DeepCopyInto(out *ClusterImportPolicySpec) {
	*out = *in
	in.Source.DeepCopyInto(&out.Source)
	if in.References != nil {
		in, out := &in.References, &out.References
		*out = make([]IntendReferenceResourceTemplate, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	out.Policy = in.Policy
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterImportPolicySpec.
func (in *ClusterImportPolicySpec) DeepCopy() *ClusterImportPolicySpec {
	if in == nil {
		return nil
	}
	out := new(ClusterImportPolicySpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterImportPolicyStatus) DeepCopyInto(out *ClusterImportPolicyStatus) {
	*out = *in
	if in.Conditions != nil {
		in, out := &in.Conditions, &out.Conditions
		*out = make([]v1.Condition, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterImportPolicyStatus.
func (in *ClusterImportPolicyStatus) DeepCopy() *ClusterImportPolicyStatus {
	if in == nil {
		return nil
	}
	out := new(ClusterImportPolicyStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DependentResource) DeepCopyInto(out *DependentResource) {
	*out = *in
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new DependentResource.
func (in *DependentResource) DeepCopy() *DependentResource {
	if in == nil {
		return nil
	}
	out := new(DependentResource)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *IntendReferenceResourceTemplate) DeepCopyInto(out *IntendReferenceResourceTemplate) {
	*out = *in
	out.BaseReferenceResourceTemplate = in.BaseReferenceResourceTemplate
	if in.Versions != nil {
		in, out := &in.Versions, &out.Versions
		*out = make([]string, len(*in))
		copy(*out, *in)
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new IntendReferenceResourceTemplate.
func (in *IntendReferenceResourceTemplate) DeepCopy() *IntendReferenceResourceTemplate {
	if in == nil {
		return nil
	}
	out := new(IntendReferenceResourceTemplate)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PediaClusterLifecycle) DeepCopyInto(out *PediaClusterLifecycle) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PediaClusterLifecycle.
func (in *PediaClusterLifecycle) DeepCopy() *PediaClusterLifecycle {
	if in == nil {
		return nil
	}
	out := new(PediaClusterLifecycle)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *PediaClusterLifecycle) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PediaClusterLifecycleList) DeepCopyInto(out *PediaClusterLifecycleList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]PediaClusterLifecycle, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PediaClusterLifecycleList.
func (in *PediaClusterLifecycleList) DeepCopy() *PediaClusterLifecycleList {
	if in == nil {
		return nil
	}
	out := new(PediaClusterLifecycleList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *PediaClusterLifecycleList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PediaClusterLifecycleSpec) DeepCopyInto(out *PediaClusterLifecycleSpec) {
	*out = *in
	out.Source = in.Source
	if in.References != nil {
		in, out := &in.References, &out.References
		*out = make([]ReferenceResourceTemplate, len(*in))
		copy(*out, *in)
	}
	out.Policy = in.Policy
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PediaClusterLifecycleSpec.
func (in *PediaClusterLifecycleSpec) DeepCopy() *PediaClusterLifecycleSpec {
	if in == nil {
		return nil
	}
	out := new(PediaClusterLifecycleSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *PediaClusterLifecycleStatus) DeepCopyInto(out *PediaClusterLifecycleStatus) {
	*out = *in
	if in.Conditions != nil {
		in, out := &in.Conditions, &out.Conditions
		*out = make([]v1.Condition, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
	if in.References != nil {
		in, out := &in.References, &out.References
		*out = make([]DependentResource, len(*in))
		copy(*out, *in)
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new PediaClusterLifecycleStatus.
func (in *PediaClusterLifecycleStatus) DeepCopy() *PediaClusterLifecycleStatus {
	if in == nil {
		return nil
	}
	out := new(PediaClusterLifecycleStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Policy) DeepCopyInto(out *Policy) {
	*out = *in
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Policy.
func (in *Policy) DeepCopy() *Policy {
	if in == nil {
		return nil
	}
	out := new(Policy)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ReferenceResourceTemplate) DeepCopyInto(out *ReferenceResourceTemplate) {
	*out = *in
	out.BaseReferenceResourceTemplate = in.BaseReferenceResourceTemplate
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ReferenceResourceTemplate.
func (in *ReferenceResourceTemplate) DeepCopy() *ReferenceResourceTemplate {
	if in == nil {
		return nil
	}
	out := new(ReferenceResourceTemplate)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SourceType) DeepCopyInto(out *SourceType) {
	*out = *in
	if in.Versions != nil {
		in, out := &in.Versions, &out.Versions
		*out = make([]string, len(*in))
		copy(*out, *in)
	}
	return
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SourceType.
func (in *SourceType) DeepCopy() *SourceType {
	if in == nil {
		return nil
	}
	out := new(SourceType)
	in.DeepCopyInto(out)
	return out
}